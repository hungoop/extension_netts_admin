
import 'package:admin_client/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/base_chat_exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';
import 'package:admin_client/utils/utils.dart';
import 'package:admin_client/validators/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(): super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    final loginState = state;

    try {
      if(loginState is LoginStateInitial){
        initWSListening();
        yield LoginStateSuccess();
      }

      if(loginEvent is LoginEventStarted){
        yield LoginStateSuccess();
      }
      else if (loginEvent is LoginEventIdentificationChanged){
        if(loginState is LoginStateSuccess){
          yield loginState.cloneWith(
              isValidIdentification: Validators.isValidIdentification(
                  loginEvent.identification,
                  loginEvent.loginType
              )
          );
        }
      }
      else if (loginEvent is LoginEventPasswordChanged) {

        if(loginState is LoginStateSuccess){
          yield loginState.cloneWith(
              isValidPassword: Validators.isValidPassword(
                  loginEvent.password
              ),
              isValidIdentification: Validators.isValidIdentification(
                  loginEvent.identification,
                  loginEvent.loginType
              )
          );
        }
      }
      else if (loginEvent is LoginEventWithEmailAndPasswordPress) {
        yield LoginStateLoading();

        Application.chatSocket.login(
            zone: Application.zoneGameName,
            uname: '${loginEvent.identification}',
            upass: '${loginEvent.password}',
            param: {
              'lt': detectLoginType(
                  loginEvent.identification,
                  loginEvent.loginType
              ).getId(),
            }
        );

        LoginStorage store = LoginStorage(
            loginEvent.identification
        );

        store.save();

      }
      else if(loginEvent is LoginEventSuccess){
        yield LoginStateSuccess();
      }
      else if(loginEvent is LoginEventFailure){
        yield LoginStateFailure(error: loginEvent.messError);
      }

    } catch (ex, stacktrace) {
      if (ex is BaseChatException) {
        yield LoginStateFailure(error:ex.toString());
      }
      else {
        yield LoginStateFailure(
            error:AppLanguage().translator(LanguageKeys.LOGIN_FAILRURE)
        );
      }

      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }

  LOGIN_TYPE detectLoginType(String identify, LOGIN_TYPE sourceType){
    if(sourceType == LOGIN_TYPE.EMAIL_OR_ID){
      if(Validators.isValidEmail(identify)){
        return LOGIN_TYPE.EMAIL;
      } else {
        print('identify:$identify is ID');
        return LOGIN_TYPE.USERNAME_PWD;
      }
    } else {
      return sourceType;
    }
  }

  @override
  Future<void> close() {
    destroyWSListening();
    return super.close();
  }

  void initWSListening(){
    Application.chatSocket.addSysListener(_onSysMessageReceived);
  }

  void destroyWSListening(){
    Application.chatSocket.removeSysListener(_onSysMessageReceived);
  }

  _onSysMessageReceived(WsSystemMessage event) {
    switch(event.cmd) {
      case WsSystemMessage.LOGIN: {
        var data = event.data;
        if(data == 'OK'){
          this.add(LoginEventSuccess());
        }
        else {
          this.add(LoginEventFailure(data));
        }

        UtilLogger.log('LOGIN', '$data');
      }
      break;
      default:{
        //UtilLogger.log('TTT SYSTEM ${event.cmd}', '${event.data}');
      }
    }
  }

}
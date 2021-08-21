import 'package:admin_client/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/utils/utils.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());

  @override
  Stream<AuthState> mapEventToState(event) async* {
    try{
      if (event is OnAuthCheck) {
        ///authentication check flow
        LoginStorage? store = LoginStorage.read();
        UtilLogger.log('LoginStorage>>>>>>', '$store');

        Application.chatSocket.connectAndLogin('auth=nett_admin');

        if(store != null && !Utils.checkDataEmpty(store.token)){
          Application.chatSocket.login(
              zone: Application.zoneGameName,
              uname: '${store.identification}',
              upass: '${store.token}',
              param: {
                'lt': LOGIN_TYPE.TOKEN.getId(),
              }
          );
        }

        yield AuthenticationFail(error: 'First Login');
      }

      if (event is OnAuthProcess) {
        ///authentication process flow
        yield AuthenticationSuccess();
      }

      if(event is OnAuthUpdate){

      }

      if (event is OnClear) {
        LoginStorage.logout();

        yield AuthenticationFail(
          error: "OnClear"
        );

        Application.chatSocket.logout();
      }
    }
    catch (ex, st) {
      print('connectAndLogin $ex');
      print('connectAndLogin $st');

      yield AuthenticationFail(
        error: ex.toString()
      );

      UtilLogger.recordError(
          ex,
          stack: st,
          fatal: true
      );
    }

  }

}
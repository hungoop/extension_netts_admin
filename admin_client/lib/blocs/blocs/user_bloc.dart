import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserView view;

  UserBloc(this.view) : super(UserStateInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    var currState = state;

    try {
      if(event is UserEventFetched) {
        if(currState is UserStateInitial){
          initWSListening();
        }

        yield UserStateSuccess(
          UserView(view.res),
        );
      }
      else if(event is UserEventDelete){
        if(currState is UserStateSuccess){
          var mes = {};
          mes["zn"] = view.res.zoneName;//zone
          if(view.roomID != -1){
            mes["ri"] = view.roomID;//room
          }
          mes["un"] = view.res.uName;//user
          Application.chatSocket.sendExtData(
              CMD.USER_DISCONNECT, mes
          );

          UtilLogger.log('USER_DISCONNECT', '$mes');

          RouteGenerator.pop();
        }

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield UserStateFailure(error: ex.toString());
      }
      else {
        yield UserStateFailure(
            error: AppLanguage().translator(
                LanguageKeys.CONNECT_SERVER_FAILRURE
            )
        );
      }

      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }
  }

  @override
  Future<void> close() {
    destroyWSListening();
    return super.close();
  }

  void getUserInRoom(){
    var mes = {};
    //mes["zn"] = res.zName;
    //mes["ri"] = res.rID;
    //Application.chatSocket.sendExtData(
    //    CMD.USER_LIST, mes
    //);

    UtilLogger.log('getUserInRoom ${CMD.USER_LIST}', '$mes');
  }

  void initWSListening(){
    Application.chatSocket.addExtListener(_onExtMessageReceived);
    Application.chatSocket.addSysListener(_onSysMessageReceived);
  }

  void destroyWSListening(){
    Application.chatSocket.removeExtListener(_onExtMessageReceived);
    Application.chatSocket.removeSysListener(_onSysMessageReceived);
  }

  _onExtMessageReceived(WsExtensionMessage event) async {
    switch(event.cmd) {
      default:{
        UtilLogger.log(
            'TTT EXT ${event.cmd}', 'hide data'
        );
      }
    }
  }

  _onSysMessageReceived(WsSystemMessage event) {
    switch(event.cmd) {
      default:{
        //UtilLogger.log('TTT SYSTEM ${event.cmd}', '${event.data}');
      }
    }
  }

}
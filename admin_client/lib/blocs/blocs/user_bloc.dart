import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRes res;
  late UserListModel userListModel;

  UserBloc(this.res) : super(UserStateInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    var currState = state;

    try {
      if(event is UserEventFetched) {
        if(currState is UserStateInitial){
          initWSListening();
          userListModel = UserListModel.fromRes([]);

          getUserInRoom();
        }

        yield UserStateSuccess(
          UserView(res),
          userListModel.dataViews,
        );
      }
      else if(event is UserEventUserList){
        if(currState is UserStateSuccess){
          userListModel = UserListModel.fromRes(event.lst);

          yield currState.cloneWith(
              userViews: userListModel.dataViews
          );
        }
      }
      else if(event is UserEventOpenUser){
        if(currState is UserStateSuccess){
          UserView posView = event.userView;
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
      case CMD.USER_LIST:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          List<UserRes> lst = UserListModel.parseRes(data);
          this.add(UserEventUserList(lst));
        }
      }
      break;
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
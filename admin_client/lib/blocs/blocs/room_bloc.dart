import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomRes res;
  late UserListModel userListModel;

  RoomBloc(this.res) : super(RoomStateInitial());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    var currState = state;

    try {
      if(event is RoomEventFetched) {
        if(currState is RoomStateInitial){
          initWSListening();
          userListModel = UserListModel.fromRes([]);

          getUserInRoom();
        }

        yield RoomStateSuccess(
            RoomView(res),
            userListModel.dataViews,
        );
      }
      else if(event is RoomEventUserList){
        if(currState is RoomStateSuccess){
          userListModel = UserListModel.fromRes(event.lst);

          yield currState.cloneWith(
              userViews: userListModel.dataViews
          );
        }
      }
      else if(event is RoomEventOpenUser){
        if(currState is RoomStateSuccess){
          UserView user = event.userView;
          RouteGenerator.pushNamed(
              ScreenRoutes.OPEN_USER,
              arguments: user.res
          );
        }

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield RoomStateFailure(error: ex.toString());
      }
      else {
        yield RoomStateFailure(
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
    mes["zn"] = res.zName;
    mes["ri"] = res.rID;
    Application.chatSocket.sendExtData(
        CMD.USER_LIST, mes
    );

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
          this.add(RoomEventUserList(lst));
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
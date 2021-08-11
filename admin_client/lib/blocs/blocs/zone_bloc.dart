import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  ZoneConfigRes server;
  late UserListModel userListModel;
  late RoomListModel roomLstOfZone;

  ZoneBloc(this.server) : super(ZoneStateInitial());

  @override
  Stream<ZoneState> mapEventToState(ZoneEvent event) async* {
    var currState = state;

    try {
      if(event is ZoneEventFetched) {
        if(currState is ZoneStateInitial){
          initWSListening();
          userListModel = UserListModel.fromRes([]);
          roomLstOfZone = RoomListModel.fromRes([]);
          getZoneInfo();
          getUserInZone();
        }
      }
      else if(event is ZoneEventGetUsers){
        if(currState is ZoneStateSuccess){
          getUserInZone();
        }
      }
      else if(event is ZoneEventUpdateUsers){
        if(currState is ZoneStateSuccess){
          userListModel = UserListModel.fromRes(event.lst);

          yield currState.cloneWith(
              userViews: userListModel.dataViews
          );
        }
      }
      else if(event is ZoneEventZoneInfo){
        if(currState is ZoneStateInitial){
          roomLstOfZone = RoomListModel.fromRes(event.rooms);
          yield ZoneStateSuccess(
              ZoneView(event.res),
              userListModel.dataViews,
              roomLstOfZone.dataViews
          );

        }
      }
      else if(event is ZoneEventRoomChoose){
        if(currState is ZoneStateSuccess){

          RouteGenerator.pushNamed(
              ScreenRoutes.OPEN_ROOM,
              arguments: event.room.res
          );
        }

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield ZoneStateFailure(error: ex.toString());
      }
      else {
        yield ZoneStateFailure(
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

  void getZoneInfo(){
    var mes = {};
    mes["zn"] = server.zoneName();
    Application.chatSocket.sendExtData(
        CMD.ZONE_INFO, mes
    );
    UtilLogger.log('ZONE_INFO', '$mes');
  }

  void getUserInZone(){
    var mes = {};
    mes["zn"] = server.zoneName();
    Application.chatSocket.sendExtData(
        CMD.USER_LIST, mes
    );

    UtilLogger.log('getUserInZone ${CMD.USER_LIST}', '$mes');
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
          this.add(ZoneEventUpdateUsers(lst));
        }
      }
      break;
      case CMD.ZONE_INFO:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          ZoneRes zoneRes = ZoneRes.fromJson(data.dataToJson());

          List<RoomRes> lst = RoomListModel.parseResFromJson(data);

          this.add(ZoneEventZoneInfo(zoneRes, lst));
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
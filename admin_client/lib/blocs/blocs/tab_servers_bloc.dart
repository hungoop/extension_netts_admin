import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/utils.dart';

class TabServersBloc extends Bloc<TabServersEvent, TabServerState> {
  late ZoneConfigsModel zoneConfigsModel;

  TabServersBloc() : super(TabServersStateInitial());

  @override
  Stream<TabServerState> mapEventToState(TabServersEvent event) async* {
    var currState = state;

    try {
      if(event is TabServersEventFetched) {
        if(currState is TabServersStateInitial){
          initWSListening();
          zoneConfigsModel = ZoneConfigsModel.fromRes([]);
        }
      }
      else if(event is TabServersEventZoneList){
        zoneConfigsModel = ZoneConfigsModel.fromRes(event.lst);

        yield TabServersStateSuccess(zoneConfigsModel.dataViews);
      }
      else if(event is TabServersEventGoToZone){
        if(currState is TabServersStateSuccess){
          RouteGenerator.pushNamed(
              ScreenRoutes.OPEN_ZONE,
              arguments: event.res
          );
        }

      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabServersStateFailure(error: ex.toString());
      }
      else {
        yield TabServersStateFailure(
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
      case CMD.ZONE_CONFIG:{
        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){
          List<ZoneConfigRes> lst = ZoneConfigsModel.parseRes(data);

          this.add(TabServersEventZoneList(lst));
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class ExtManagerBloc extends Bloc<ExtEvent, ExtState> {
  ZoneRes res;

  ExtManagerBloc(this.res) : super(ExtStateInitial());

  @override
  Stream<ExtState> mapEventToState(ExtEvent event) async* {
    var currState = state;

    try {
      if(event is ExtEventFetched) {
        if(currState is ExtStateInitial){
          initWSListening();

          getZoneInfo();
        }

        //yield ExtStateSuccess(
        //  ExtView(res),
        //);
      }
      else if(event is ExtEventUpdateRes){
        //if(currState is ExtStateSuccess){

        yield ExtStateSuccess(
          ExtView(event.res),
        );
        //}
      }
      else if(event is ExtEventStop){
        if(currState is ExtStateSuccess){
          var mes = {};
          mes["zn"] = res.zName;
          Application.chatSocket.sendExtData(
              CMD.EXT_STOP, mes
          );
          UtilLogger.log('EXT_STOP', '$mes');

          RouteGenerator.pop();
        }
      }
      else if(event is ExtEventStart){
        if(currState is ExtStateSuccess){
          var mes = {};
          mes["zn"] = res.zName;
          Application.chatSocket.sendExtData(
              CMD.EXT_START, mes
          );
          UtilLogger.log('EXT_START', '$mes');

          RouteGenerator.pop();
        }
      }
      else if(event is ExtEventReload){
        if(currState is ExtStateSuccess){
          var mes = {};
          mes["sn"] = res.xmlZoneName();
          Application.chatSocket.sendExtData(
              CMD.EXT_RELOAD, mes
          );
          UtilLogger.log('EXT_RELOAD', '$mes');

          RouteGenerator.pop();
        }
      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield ExtStateFailure(error: ex.toString());
      }
      else {
        yield ExtStateFailure(
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
    mes["zn"] = res.zName;
    Application.chatSocket.sendExtData(
        CMD.ZONE_INFO, mes
    );
    UtilLogger.log('ZONE_INFO', '$mes');
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
      case CMD.ZONE_INFO:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          ExtRes extRes = ExtRes.fromJson(
              res.zID,
              res.zName,
              data.dataExtensionData()
          );
          this.add(ExtEventUpdateRes(extRes));
        }
      }
      break;
      default:{
        //UtilLogger.log(
            //'TTT EXT ${event.cmd}', 'hide data'
        //);
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
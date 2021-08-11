import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/utils.dart';

class TabSessionsBloc extends Bloc<TabSessionsEvent, TabSessionsState> {
  late SessionListModel sessionListModel;

  TabSessionsBloc() : super(TabSessionsStateInitial());

  @override
  Stream<TabSessionsState> mapEventToState(TabSessionsEvent event) async* {
    var currState = state;

    try {
      if(event is TabSessionsEventFetched) {
        if(currState is TabSessionsStateInitial){
          initWSListening();
          sessionListModel = SessionListModel.fromRes([]);
        }
      }
      else if(event is TabSessionsEventUpdateLst){
        sessionListModel = SessionListModel.fromRes(event.lst);

        yield TabSessionsStateSuccess(sessionListModel.dataViews);
      }
      else if(event is TabSessionsEventSelected){

      }
      else if(event is TabSessionsEventDelete){
        if(currState is TabSessionsStateSuccess){
          var mes = {};
          mes["zn"] = event.res.zoneName;
          mes["si"] = event.res.sID;
          Application.chatSocket.sendExtData(
              CMD.SESSION_DISCONNECT, mes
          );

          UtilLogger.log('SESSION_DISCONNECT', '$mes');
        }
      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabSessionsStateFailure(error: ex.toString());
      }
      else {
        yield TabSessionsStateFailure(
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
      case CMD.SESSION_LIST:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          List<SessionRes> lst = SessionListModel.parseRes(data);

          this.add(TabSessionsEventUpdateLst(lst));
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/utils.dart';

class TabSessionsBloc extends Bloc<TabSessionsEvent, TabUserState> {
  late SessionListModel sessionListModel;

  TabSessionsBloc() : super(TabUserStateInitial());

  @override
  Stream<TabUserState> mapEventToState(TabSessionsEvent event) async* {
    var currState = state;

    try {
      if(event is TabSessionsEventFetched) {
        if(currState is TabUserStateInitial){
          initWSListening();
          sessionListModel = SessionListModel.fromRes([]);
        }
      }
      else if(event is TabSessionsEventUserList){
        sessionListModel = SessionListModel.fromRes(event.lst);

        yield TabUserStateSuccess(sessionListModel.dataViews);
      }
      else if(event is TabSessionsEventJoinRoom){
        if(currState is TabLobbyStateSuccess){
          RouteGenerator.pushNamed(
              ScreenRoutes.OPEN_ZONE,
              arguments: event.res
          );
        }

      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabUserStateFailure(error: ex.toString());
      } else {
        yield TabUserStateFailure(
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

        //UtilLogger.log('SESSION_LIST', '$data');

        if(data.isOK(iSuccess: 0)){
          List<SessionRes> lst = SessionListModel.parseRes(data);

          this.add(TabSessionsEventUserList(lst));
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
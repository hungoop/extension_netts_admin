import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class ServerPropertyBloc extends Bloc<ServerPropertyEvent, ServerPropertyState> {

  ServerPropertyBloc() : super(ServerPropertyStateInitial());

  @override
  Stream<ServerPropertyState> mapEventToState(ServerPropertyEvent event) async* {
    var currState = state;

    try {
      if(event is ServerPropertyEventFetched) {
        if(currState is ServerPropertyStateInitial){
          initWSListening();
        }

        getServerProp();
      }
      if(event is ServerPropertyEventUpdate) {
        yield ServerPropertyStateSuccess(
          ServerProtocolView(event.res),
        );
      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield ServerPropertyStateFailure(error: ex.toString());
      }
      else {
        yield ServerPropertyStateFailure(
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

  void getServerProp(){
    var mes = {};
    Application.chatSocket.sendExtData(
        CMD.SERVER_PROPERTY, mes
    );

    UtilLogger.log('SERVER_PROPERTY', '$mes');
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
      case CMD.SERVER_PROPERTY: {
        UtilLogger.log('SERVER_PROPERTY', '${event.data}');

        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){
          ServerProtocolRes svRes = ServerProtocolRes.fromJson(data.dataToJson());

          this.add(ServerPropertyEventUpdate(svRes));
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
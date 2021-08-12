import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class ServerProtocolBloc extends Bloc<ServerProtocolEvent, ServerProtocolState> {
  late ServerProtocolModel protocolModel;

  ServerProtocolBloc() : super(ServerProtocolStateInitial());

  @override
  Stream<ServerProtocolState> mapEventToState(ServerProtocolEvent event) async* {
    var currState = state;

    try {
      if(event is ServerProtocolEventFetched) {
        if(currState is ServerProtocolStateInitial){
          initWSListening();
          protocolModel = ServerProtocolModel.fromRes([]);
        }
        getServerProtocol();

        yield ServerProtocolStateSuccess(
          protocolModel.dataViews,
        );
      }
      if(event is ServerProtocolEventUpdate) {
        if(currState is ServerProtocolStateSuccess){
          protocolModel = ServerProtocolModel.fromRes(event.resLst);

          yield currState.cloneWith(
            viewLst: protocolModel.dataViews
          );
        }
      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield ServerProtocolStateFailure(error: ex.toString());
      }
      else {
        yield ServerProtocolStateFailure(
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

  void getServerProtocol(){
    var mes = {};
    Application.chatSocket.sendExtData(
        CMD.SERVER_PROTOCOL, mes
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
      case CMD.SERVER_PROTOCOL: {
        UtilLogger.log('SERVER_PROTOCOL', '${event.data}');

        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){
          List<ServerProtocolRes> lst = ServerProtocolModel.parseRes(data);

          this.add(ServerProtocolEventUpdate(lst));
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
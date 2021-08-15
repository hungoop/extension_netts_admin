import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class BanManagerBloc extends Bloc<BanManagerEvent, BanManagerState> {

  BanManagerBloc() : super(BanManagerStateInitial());

  @override
  Stream<BanManagerState> mapEventToState(BanManagerEvent event) async* {
    var currState = state;

    try {
      if(event is BanManagerEventFetched) {
        if(currState is BanManagerStateInitial){
          initWSListening();
        }
        getBanData();

      }
      else if(event is BanManagerEventUpdate){
        //if(currState is BanManagerStateSuccess){
          yield BanManagerStateSuccess(
            BanView(event.res),
          );
        //}

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield BanManagerStateFailure(error: ex.toString());
      }
      else {
        yield BanManagerStateFailure(
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

  void getBanData(){
    var mes = {};
    Application.chatSocket.sendExtData(
        CMD.UPDATE_BAN, mes
    );

    UtilLogger.log('UPDATE_BAN', '$mes');
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
      case CMD.UPDATE_BAN: {
        UtilLogger.log('UPDATE_BAN', '${event.data}');

        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){
          BanRes svRes = BanRes.fromJson(data.dataToJson());

          this.add(BanManagerEventUpdate(svRes));
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
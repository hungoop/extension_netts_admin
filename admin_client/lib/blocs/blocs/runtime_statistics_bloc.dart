import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class RStatisticsBloc extends Bloc<RStatisticsEvent, RStatisticsState> {

  RStatisticsBloc() : super(RStatisticsStateInitial());

  @override
  Stream<RStatisticsState> mapEventToState(RStatisticsEvent event) async* {
    var currState = state;

    try {
      if(event is RStatisticsEventFetched) {
        if(currState is RStatisticsStateInitial){
          initWSListening();
        }
        getStatisticsData();

      }
      else if(event is RStatisticsEventUpdate){
        //if(currState is BanManagerStateSuccess){
        yield RStatisticsStateSuccess(
          RStatisticsView(event.res),
        );
        //}

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield RStatisticsStateFailure(error: ex.toString());
      }
      else {
        yield RStatisticsStateFailure(
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

  void getStatisticsData(){
    var mes = {};
    Application.chatSocket.sendExtData(
        CMD.R_STATISTICS, mes
    );

    UtilLogger.log('R_STATISTICS', '$mes');
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
      case CMD.R_STATISTICS: {
        UtilLogger.log('UPDATE_BAN', '${event.data}');

        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){
          RStatisticsRes rRes = RStatisticsRes.fromJson(data.dataToJson());

          this.add(RStatisticsEventUpdate(rRes));
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
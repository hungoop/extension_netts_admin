import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_client/blocs/blocs.dart';
import 'package:admin_client/configs/configs.dart';
import 'package:admin_client/exception/exception.dart';
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';
import 'package:admin_client/utils/util_logger.dart';

class AccManagerBloc extends Bloc<AccManagerEvent, AccManagerState> {
  late AccountManagerModel _accountManagerModel;

  AccManagerBloc() : super(AccManagerStateInitial());

  @override
  Stream<AccManagerState> mapEventToState(AccManagerEvent event) async* {
    var currState = state;

    try {
      if(event is AccManagerEventFetched) {
        if(currState is AccManagerStateInitial){
          initWSListening();
          _accountManagerModel = AccountManagerModel.fromRes([]);
        }

        getAccData();
      }
      else if(event is AccManagerEventUpdate){
        _accountManagerModel = AccountManagerModel.fromRes(
            event.lstAdminRes
        );

        yield AccManagerStateSuccess(
            _accountManagerModel.dataViews
        );

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield AccManagerStateFailure(error: ex.toString());
      }
      else {
        yield AccManagerStateFailure(
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

  void getAccData(){
    var mes = {};
    Application.chatSocket.sendExtData(
        CMD.UPDATE_ACC, mes
    );

    UtilLogger.log('UPDATE_ACC', '$mes');
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
      case CMD.UPDATE_ACC: {
        UtilLogger.log('UPDATE_ACC', '${event.data}');

        DataPackage data = DataPackage.fromJson(event.data);
        if(data.isOK(iSuccess: 0)){

          List<AccountRes> accAdmins = AccountManagerModel.parseRes(data);

          this.add(AccManagerEventUpdate(accAdmins));
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
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class ServerPropertyState {}

class ServerPropertyStateInitial extends ServerPropertyState {}

class ServerPropertyStateFailure extends ServerPropertyState {
  final String error;

  ServerPropertyStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class ServerPropertyStateSuccess extends ServerPropertyState {
  final ServerProtocolView dataView;

  ServerPropertyStateSuccess(
      this.dataView,
  );

  ServerPropertyStateSuccess cloneWith({
    ServerProtocolView? dataView,
  }){
    return ServerPropertyStateSuccess(
      dataView ?? this.dataView,
    );
  }

}
class ServerPropertyStateLoading extends ServerPropertyState {}
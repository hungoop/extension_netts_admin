import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class ServerProtocolState {}

class ServerProtocolStateInitial extends ServerProtocolState {}

class ServerProtocolStateFailure extends ServerProtocolState {
  final String error;

  ServerProtocolStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class ServerProtocolStateSuccess extends ServerProtocolState {
  final List<ServerProtocolView> views;

  ServerProtocolStateSuccess(
      this.views,
      );

  ServerProtocolStateSuccess cloneWith({
    List<ServerProtocolView>? viewLst,
  }){
    return ServerProtocolStateSuccess(
      viewLst ?? this.views,
    );
  }

}
class ServerProtocolStateLoading extends ServerProtocolState {}
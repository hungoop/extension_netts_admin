
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class TabLobbyState {}

class TabLobbyStateInitial extends TabLobbyState {}

class TabLobbyStateFailure extends TabLobbyState {
  final String error;

  TabLobbyStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabLobbyStateSuccess extends TabLobbyState {
  List<ZoneConfigView> views;

  TabLobbyStateSuccess(this.views);

}

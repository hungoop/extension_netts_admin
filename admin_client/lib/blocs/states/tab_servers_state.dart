
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class TabServerState {}

class TabServersStateInitial extends TabServerState {}

class TabServersStateFailure extends TabServerState {
  final String error;

  TabServersStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabServersStateSuccess extends TabServerState {
  List<ZoneConfigView> views;

  TabServersStateSuccess(this.views);

}

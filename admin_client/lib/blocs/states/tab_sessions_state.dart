
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class TabSessionsState {}

class TabSessionsStateInitial extends TabSessionsState {}

class TabSessionsStateFailure extends TabSessionsState {
  final String error;

  TabSessionsStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabSessionsStateSuccess extends TabSessionsState {
  List<SessionView> views;

  TabSessionsStateSuccess(this.views);

}
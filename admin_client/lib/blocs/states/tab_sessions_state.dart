
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class TabUserState {}

class TabUserStateInitial extends TabUserState {}

class TabUserStateFailure extends TabUserState {
  final String error;

  TabUserStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabUserStateSuccess extends TabUserState {
  List<SessionView> views;

  TabUserStateSuccess(this.views);

}
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class UserState {}

class UserStateInitial extends UserState {}

class UserStateFailure extends UserState {
  final String error;

  UserStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class UserStateSuccess extends UserState {
  final UserView dataView;

  UserStateSuccess(
      this.dataView,
  );

  UserStateSuccess cloneWith({
    UserView? dataView,
    List<UserView>? userViews,
  }){
    return UserStateSuccess(
      dataView ?? this.dataView,
    );
  }

}
class UserStateLoading extends UserState {}
import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class BanManagerState {}

class BanManagerStateInitial extends BanManagerState {}

class BanManagerStateFailure extends BanManagerState {
  final String error;

  BanManagerStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class BanManagerStateSuccess extends BanManagerState {
  final BanView dataView;

  BanManagerStateSuccess(
      this.dataView,
      );

  BanManagerStateSuccess cloneWith({
    BanView? dataView,
  }){
    return BanManagerStateSuccess(
      dataView ?? this.dataView,
    );
  }

}
class BanManagerStateLoading extends BanManagerState {}
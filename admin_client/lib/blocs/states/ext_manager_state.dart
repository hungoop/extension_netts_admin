import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class ExtState {}

class ExtStateInitial extends ExtState {}

class ExtStateFailure extends ExtState {
  final String error;

  ExtStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class ExtStateSuccess extends ExtState {
  final ExtView dataView;

  ExtStateSuccess(
      this.dataView,
  );

  ExtStateSuccess cloneWith({
    ExtView? dataView,
  }){
    return ExtStateSuccess(
      dataView ?? this.dataView,
    );
  }


}
class ExtStateLoading extends ExtState {}
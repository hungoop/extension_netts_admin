import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/dataview/account_view.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class AccManagerState {}

class AccManagerStateInitial extends AccManagerState {}

class AccManagerStateFailure extends AccManagerState {
  final String error;

  AccManagerStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class AccManagerStateSuccess extends AccManagerState {
  final List<AccountView> lstAdminView;

  AccManagerStateSuccess(
      this.lstAdminView,
  );

  AccManagerStateSuccess cloneWith({
    List<AccountView>? lstAdminView,
  }){
    return AccManagerStateSuccess(
      lstAdminView ?? this.lstAdminView,
    );
  }

}
class AccManagerStateLoading extends AccManagerState {}
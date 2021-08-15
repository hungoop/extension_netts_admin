import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class RStatisticsState {}

class RStatisticsStateInitial extends RStatisticsState {}

class RStatisticsStateFailure extends RStatisticsState {
  final String error;

  RStatisticsStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class RStatisticsStateSuccess extends RStatisticsState {
  final RStatisticsView dataView;

  RStatisticsStateSuccess(
      this.dataView,
      );

  RStatisticsStateSuccess cloneWith({
    RStatisticsView? dataView,
  }){
    return RStatisticsStateSuccess(
      dataView ?? this.dataView,
    );
  }

}
class RStatisticsStateStateLoading extends RStatisticsState {}
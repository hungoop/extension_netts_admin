import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class ZoneState {}

class ZoneStateInitial extends ZoneState {}

class ZoneStateFailure extends ZoneState {
  final String error;

  ZoneStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class ZoneStateSuccess extends ZoneState {
  final ZoneView dataView;
  final List<UserView> userViews;
  final List<RoomView> roomViews;

  ZoneStateSuccess(
      this.dataView,
      this.userViews,
      this.roomViews
  );

  ZoneStateSuccess cloneWith({
    ZoneView? dataView,
    List<UserView>? userViews,
    List<RoomView>? roomViews
  }){
    return ZoneStateSuccess(
        dataView ?? this.dataView,
        userViews ?? this.userViews,
        roomViews ?? this.roomViews
    );
  }


}

class ZoneStateLoading extends ZoneState {}
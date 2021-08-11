import 'package:admin_client/language/languages.dart';
import 'package:admin_client/models/models.dart';
import 'package:admin_client/utils/utils.dart';

abstract class RoomState {}

class RoomStateInitial extends RoomState {}

class RoomStateFailure extends RoomState {
  final String error;

  RoomStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class RoomStateSuccess extends RoomState {
  final RoomView dataView;
  final List<UserView> userViews;

  RoomStateSuccess(
      this.dataView,
      this.userViews,
  );

  RoomStateSuccess cloneWith({
    RoomView? dataView,
    List<UserView>? userViews,
  }){
    return RoomStateSuccess(
        dataView ?? this.dataView,
        userViews ?? this.userViews,
    );
  }


}
class RoomStateLoading extends RoomState {}
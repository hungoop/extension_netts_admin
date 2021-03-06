import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class UserListModel {
  List<UserView> dataViews;

  UserListModel(this.dataViews);

  factory UserListModel.fromRes(List<UserRes> lst){
    List<UserView> temps = lst.map((e) {
      return UserView(e);
    }).toList();

    return UserListModel(temps);
  }

  static List<UserRes> parseRes(DataPackage data){
    List<UserRes> lst = data.dataToList().map((e) {
      return UserRes.fromJson(e);
    }).toList();

    return lst;
  }

}
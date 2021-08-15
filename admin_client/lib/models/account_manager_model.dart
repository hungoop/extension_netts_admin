import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class AccountManagerModel{
  List<AccountView> dataViews;

  AccountManagerModel(this.dataViews);

  factory AccountManagerModel.fromRes(List<AccountRes> lst){
    List<AccountView> temps = lst.map((e) {
      return AccountView(e);
    }).toList();

    return AccountManagerModel(temps);
  }

  static List<AccountRes> parseRes(DataPackage data){
    List<AccountRes> accAdmins = data.dataAdmins().map((e) {
      return AccountRes.fromJson(ACC_TYPE.ADMIN, e);
    }).toList();

    List<AccountRes> accUsers = data.dataUsers().map((e) {
      return AccountRes.fromJson(ACC_TYPE.USER, e);
    }).toList();


    accAdmins.addAll(accUsers);

    return accAdmins;
  }
}
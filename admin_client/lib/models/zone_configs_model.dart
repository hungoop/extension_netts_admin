import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class ZoneConfigsModel {
  List<ZoneConfigView> dataViews;

  ZoneConfigsModel(this.dataViews);

  factory ZoneConfigsModel.fromRes(List<ZoneConfigRes> lst){
    List<ZoneConfigView> temps = lst.map((e) {
      return ZoneConfigView(e);
    }).toList();

    return ZoneConfigsModel(temps);
  }

  static List<ZoneConfigRes> parseRes(DataPackage data){
    List<ZoneConfigRes> lst = data.dataToList().map((e) {
      return ZoneConfigRes.fromJson(e);
    }).toList();

    return lst;
  }

}
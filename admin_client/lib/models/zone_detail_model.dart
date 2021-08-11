import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class ZoneDetailModel {
  List<ZoneView> dataViews;

  ZoneDetailModel(this.dataViews);

  factory ZoneDetailModel.fromRes(List<ZoneRes> lst){
    List<ZoneView> temps = lst.map((e) {
      return ZoneView(e);
    }).toList();

    return ZoneDetailModel(temps);
  }

  static List<ZoneRes> parseRes(DataPackage data){
    List<ZoneRes> lst = data.dataToList().map((e) {
      return ZoneRes.fromJson(e);
    }).toList();

    return lst;
  }

}
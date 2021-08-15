

import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class ServerProtocolModel {
  List<ServerProtocolView> dataViews;

  ServerProtocolModel(this.dataViews);

  factory ServerProtocolModel.fromRes(List<ServerProtocolRes> lst){
    List<ServerProtocolView> temps = lst.map((e) {
      return ServerProtocolView(e);
    }).toList();

    return ServerProtocolModel(temps);
  }

  static List<ServerProtocolRes> parseRes(DataPackage data){
    List<ServerProtocolRes> lst = data.dataToList().map((e) {
      return ServerProtocolRes.fromJson(e);
    }).toList();

    return lst;
  }

}
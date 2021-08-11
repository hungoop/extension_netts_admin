import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class SessionListModel {
  List<SessionView> dataViews;

  SessionListModel(this.dataViews);

  factory SessionListModel.fromRes(List<SessionRes> lst){
    List<SessionView> temps = lst.map((e) {
      return SessionView(e);
    }).toList();

    return SessionListModel(temps);
  }

  static List<SessionRes> parseRes(DataPackage data){
    List<SessionRes> lst = data.dataToList().map((e) {
      return SessionRes.fromJson(e);
    }).toList();

    return lst;
  }
}
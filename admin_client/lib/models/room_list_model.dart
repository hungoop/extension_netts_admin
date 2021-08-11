import 'package:admin_client/models/models.dart';
import 'package:admin_client/repository/repository.dart';

class RoomListModel {
  List<RoomView> dataViews;

  RoomListModel(this.dataViews);

  factory RoomListModel.fromRes(List<RoomRes> lst){
    List<RoomView> temps = lst.map((e) {
      return RoomView(e);
    }).toList();

    return RoomListModel(temps);
  }

  static List<RoomRes> parseRes(DataPackage data){
    List<RoomRes> lst = data.dataToList().map((e) {
      return RoomRes.fromJson(e);
    }).toList();

    return lst;
  }

  static List<RoomRes> parseResFromJson(DataPackage data){
    List<dynamic> dataRooms() {
      return data.dataToJson()["LIST_ROOM"] as List;
    }

    List<RoomRes> lst = dataRooms().map((e) {
      return RoomRes.fromJson(e);
    }).toList();

    return lst;
  }

}
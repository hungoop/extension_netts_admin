import 'dart:convert';

class ZoneConfigRes{
  String zName;
  String zPath;

  ZoneConfigRes(this.zName, this.zPath);

  factory ZoneConfigRes.fromJson(dynamic json){
    return ZoneConfigRes(
      json["name"],
      json["path"],

    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['name'] = this.zName;
    map['path'] = this.zPath;

    return map;
  }

  String zoneName(){
    return zName.split('.')[0];
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}
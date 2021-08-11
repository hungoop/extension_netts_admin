
/*
[{"ZONE_NAME":"","IS_CONNECTED":true,"IP":"N\/A","JOIN_ROOM":[],
"HOST":"N\/A","ID":"3c22fbfffee6120a-000026e2-00000005-6f52e1a75547ee31-7fbda9c2",
"NAME":""},
{"ZONE_NAME":"NETTSAdminZone",
"LAST_JOIN":1,"IS_CONNECTED":true,"IP":"N\/A","JOIN_ROOM":[1],
"HOST":"N\/A","ID":"3c22fbfffee6120a-000026e2-00000006-6f87a95ed949124a-84098f64",
"NAME":"root"}]
 */
import 'dart:convert';

class SessionRes {
  String sID;
  String sName;
  String sessionID;
  int lastJoin;
  List<dynamic> joinRoons;
  bool isConnected;
  String ipAddress;
  String hostAddress;
  String zoneName;

  SessionRes({
    required this.sID,
    required this.sName,
    required this.sessionID,
    required this.lastJoin,
    required this.joinRoons,
    required this.isConnected,
    required this.ipAddress,
    required this.hostAddress,
    required this.zoneName,
  });

  factory SessionRes.fromJson(dynamic json){
    return SessionRes(
      sID: json["ID"],
      sName: json["NAME"],
      sessionID: json["SESSION_ID"] ?? "n/a",
      lastJoin: json["LAST_JOIN"] ?? -1,
      joinRoons: json["JOIN_ROOM"] ?? [],
      isConnected: json["IS_CONNECTED"],
      ipAddress: json["IP"],
      hostAddress: json["HOST"],
      zoneName: json["ZONE_NAME"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['ID'] = this.sID;
    map['NAME'] = this.sName;
    map['SESSION_ID'] = this.sessionID;
    map['PLAYER_ID'] = this.lastJoin;
    map['LAST_JOIN'] = this.joinRoons;
    map['IS_CONNECTED'] = this.isConnected;
    map['IP'] = this.ipAddress;
    map['HOST'] = this.hostAddress;
    map['ZONE_NAME'] = this.zoneName;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
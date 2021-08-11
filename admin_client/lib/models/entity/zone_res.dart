
/*
  {"NOTIFY_REMOVE_ROOM":true,"TOTAL_USER":0,"CUSTOM_LOGIN":false,
  "LIST_ROOM":[],"MAX_USER":3500,
  "EXTENSION":{"CachedHandlers":
  {"ttt.nett.server.handler.system.RoomAddedHandler":"ttt.nett.server.handler.system.RoomAddedHandler@22744af6",
  "ttt.nett.server.handler.system.ZoneAddedHandler":"ttt.nett.server.handler.system.ZoneAddedHandler@13ad1b5b",
  "ttt.nett.server.handler.system.ServerReadyHandler":"ttt.nett.server.handler.system.ServerReadyHandler@703d4e80"},
  "RequestHandler":{"playgame":class ttt.nett.server.handler.ext.ws.PlayGameWSRequest,
  "invitefriend":class ttt.nett.server.handler.ext.ws.InviteFriendWSRequest,
  "userinroom":class ttt.nett.server.handler.ext.ws.GetUserInRoomReqest,
  "gettime":class ttt.nett.server.handler.ext.ws.GetTimeServerWSRequest,
  "stopgame":class ttt.nett.server.handler.ext.ws.StopGameWSRequest,
  "startgame":class ttt.nett.server.handler.ext.ws.StartGameWSRequest},
  "EventHandler":{"USER_JOIN_ZONE":class ttt.nett.server.handler.system.UserJoinZoneHandler,
  "USER_LOGOUT":class ttt.nett.server.handler.system.UserLogoutHandler,
  "ZONE_ADDED":class ttt.nett.server.handler.system.ZoneAddedHandler,
  "ROOM_REMOVED":class ttt.nett.server.handler.system.RoomRemovedHandler,
  "USER_JOIN_ROOM":class ttt.nett.server.handler.system.UserJoinRoomHandler,
  "SERVER_READY":class ttt.nett.server.handler.system.ServerReadyHandler,
  "USER_LOGIN":class ttt.nett.server.handler.system.UserLoginHandler,
  "USER_LEAVE_ROOM":class ttt.nett.server.handler.system.UserLeaveRoomHandler,
  "ROOM_ADDED":class ttt.nett.server.handler.system.RoomAddedHandler,
  "USER_DISCONNECT":class ttt.nett.server.handler.system.UserDisconnectHandler},
  "IsServerStoped":false},
  "ID":7,"IS_MEDIA":false,
  "MAX_ROOM":1000,"NOTIFY_CREATE_ROOM":true,"NAME":"ttt_game",
  "FORCE_LOGOUT":true}
*/
import 'dart:convert';

class ZoneRes {
  int zID;
  String zName;
  int totalUser;
  int maxUser;
  int maxRoom;
  bool customLogin;
  bool forceLogout;
  bool isMedia;
  bool notifyRemoveRoom;
  bool notifyCreateRoom;

  ZoneRes({
    required this.zID,
    required this.zName,
    required this.totalUser,
    required this.maxUser,
    required this.maxRoom,
    required this.customLogin,
    required this.forceLogout,
    required this.isMedia,
    required this.notifyRemoveRoom,
    required this.notifyCreateRoom,
  });


  factory ZoneRes.fromJson(dynamic json){
    return ZoneRes(
      zID: json["ID"],
      zName: json["NAME"],
      totalUser: json["TOTAL_USER"],
      maxUser: json["MAX_USER"],
      maxRoom: json["MAX_ROOM"],
      customLogin: json["CUSTOM_LOGIN"],
      forceLogout: json["FORCE_LOGOUT"],
      isMedia: json["IS_MEDIA"],
      notifyRemoveRoom: json["NOTIFY_REMOVE_ROOM"],
      notifyCreateRoom: json["NOTIFY_CREATE_ROOM"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['ID'] = this.zID;
    map['NAME'] = this.zName;
    map['TOTAL_USER'] = this.totalUser;
    map['MAX_USER'] = this.maxUser;
    map['MAX_ROOM'] = this.maxRoom;
    map['CUSTOM_LOGIN'] = this.customLogin;
    map['FORCE_LOGOUT'] = this.forceLogout;
    map['IS_MEDIA'] = this.isMedia;
    map['NOTIFY_REMOVE_ROOM'] = this.notifyRemoveRoom;
    map['NOTIFY_CREATE_ROOM'] = this.notifyCreateRoom;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  String xmlZoneName(){
    return '${this.zName}.zone.xml';
  }

}
import 'dart:convert';
/*
  ZONE_INFO:{"NOTIFY_REMOVE_ROOM":true,"TOTAL_USER":0,"CUSTOM_LOGIN":false,
  "LIST_ROOM":[{"ZONE_NAME":"ttt_game","ROOM_ID":1,"ROOM_MAX_PLAYER":1000,
  "ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"game room 0","ROOM_USER_COUNT":0,
  "ROOM_MAX_SPECTATOR":1000,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,
  "ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},
  {"ZONE_NAME":"ttt_game","ROOM_ID":2,"ROOM_MAX_PLAYER":10,
  "ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_0",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":3,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_1",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":4,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_2",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":5,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_3",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":6,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_4",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":7,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_5",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":8,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_6",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":9,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_7",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":10,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_8",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":11,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_9",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":12,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_10",
  "ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,
  "ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game",
  "ROOM_ID":13,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,
  "ROOM_NAME":"ttt_room_11","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,
  "LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,
  "ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},
  {"ZONE_NAME":"ttt_game","ROOM_ID":14,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,
  "ROOM_NAME":"ttt_room_12","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,
  "LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,
  "ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},
  {"ZONE_NAME":"ttt_game","ROOM_ID":15,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_13","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],
  "ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":16,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_14","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":17,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_15","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},
  {"ZONE_NAME":"ttt_game","ROOM_ID":18,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_16","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":19,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_17","ROOM_USER_COUNT":0,
  "ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,"ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},
  {"ZONE_NAME":"ttt_game","ROOM_ID":20,"ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,
  "ROOM_NAME":"ttt_room_18","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,
  "LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,
  "ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true},{"ZONE_NAME":"ttt_game","ROOM_ID":21,
  "ROOM_MAX_PLAYER":10,"ROOM_NOTIFY_USER_LOST":true,"ROOM_NAME":"ttt_room_19","ROOM_USER_COUNT":0,"ROOM_MAX_SPECTATOR":100,"LIST_USERS":[],"ROOM_IS_ACTIVE":true,"ROOM_NOTIFY_ENTER_ROOM":true,
  "ROOM_IS_EMPTY":true,"ROOM_NOTIFY_EXIT_ROOM":true}],
  "MAX_USER":3500,
  "EXTENSION":
  {"CachedHandlers":
  {
  "ttt.nett.server.handler.system.RoomAddedHandler":"ttt.nett.server.handler.system.RoomAddedHandler@60474cef",
  "ttt.nett.server.handler.system.ZoneAddedHandler":"ttt.nett.server.handler.system.ZoneAddedHandler@79744cd8",
  "ttt.nett.server.handler.system.ServerReadyHandler":"ttt.nett.server.handler.system.ServerReadyHandler@162e3e50"
  },
  "RequestHandler":{
  "playgame":"class ttt.nett.server.handler.ext.ws.PlayGameWSRequest",
  "invitefriend":"class ttt.nett.server.handler.ext.ws.InviteFriendWSRequest",
  "userinroom":"class ttt.nett.server.handler.ext.ws.GetUserInRoomReqest",
  "gettime":"class ttt.nett.server.handler.ext.ws.GetTimeServerWSRequest",
  "stopgame":"class ttt.nett.server.handler.ext.ws.StopGameWSRequest",
  "startgame":"class ttt.nett.server.handler.ext.ws.StartGameWSRequest"
  },
  "EventHandler":
  {
  "USER_JOIN_ZONE":"class ttt.nett.server.handler.system.UserJoinZoneHandler",
  "USER_LOGOUT":"class ttt.nett.server.handler.system.UserLogoutHandler",
  "ZONE_ADDED":"class ttt.nett.server.handler.system.ZoneAddedHandler",
  "ROOM_REMOVED":"class ttt.nett.server.handler.system.RoomRemovedHandler",
  "USER_JOIN_ROOM":"class ttt.nett.server.handler.system.UserJoinRoomHandler",
  "SERVER_READY":"class ttt.nett.server.handler.system.ServerReadyHandler",
  "USER_LOGIN":"class ttt.nett.server.handler.system.UserLoginHandler",
  "USER_LEAVE_ROOM":"class ttt.nett.server.handler.system.UserLeaveRoomHandler",
  "ROOM_ADDED":"class ttt.nett.server.handler.system.RoomAddedHandler",
  "USER_DISCONNECT":"class ttt.nett.server.handler.system.UserDisconnectHandler"
  },
  "IsServerStoped":false},"ID":28,"IS_MEDIA":false,"MAX_ROOM":1000,
  "NOTIFY_CREATE_ROOM":true,"NAME":"ttt_game","FORCE_LOGOUT":true}
 */
class ExtRes {
  int zID;
  String zName;
  Map<String, dynamic> requestHandler;
  Map<String, dynamic> eventHandler;
  Map<String, dynamic> cachedHandlers;
  bool isStopped;

  ExtRes({
    required this.zID,
    required this.zName,
    required this.requestHandler,
    required this.eventHandler,
    required this.cachedHandlers,
    required this.isStopped,
  });

  factory ExtRes.fromJson(int id, String name, dynamic json){
    return ExtRes(
      zID: id,
      zName: name,
      requestHandler: json["RequestHandler"] ?? {},
      eventHandler: json["EventHandler"] ?? {},
      cachedHandlers: json["CachedHandlers"] ?? {},
      isStopped: json["IsServerStoped"] ?? true,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['ID'] = this.zID;
    map['NAME'] = this.zName;
    map['RequestHandler'] = this.requestHandler;
    map['EventHandler'] = this.eventHandler;
    map['CachedHandlers'] = this.cachedHandlers;
    map['IsServerStoped'] = this.isStopped;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}
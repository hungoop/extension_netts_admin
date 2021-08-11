import 'package:admin_client/models/models.dart';

abstract class TabSessionsEvent{}

class TabSessionsEventFetched extends TabSessionsEvent {}

class TabSessionsEventUserList extends TabSessionsEvent {
  List<SessionRes> lst;

  TabSessionsEventUserList(this.lst);

}

class TabSessionsEventJoinRoom extends TabSessionsEvent {
  SessionRes res;

  TabSessionsEventJoinRoom(this.res);

}
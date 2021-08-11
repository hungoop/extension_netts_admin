import 'package:admin_client/models/models.dart';

abstract class TabSessionsEvent{}

class TabSessionsEventFetched extends TabSessionsEvent {}

class TabSessionsEventUpdateLst extends TabSessionsEvent {
  List<SessionRes> lst;

  TabSessionsEventUpdateLst(this.lst);

}

class TabSessionsEventSelected extends TabSessionsEvent {
  SessionRes res;

  TabSessionsEventSelected(this.res);

}

class TabSessionsEventDelete extends TabSessionsEvent {
  SessionRes res;

  TabSessionsEventDelete(this.res);

}
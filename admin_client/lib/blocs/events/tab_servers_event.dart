import 'package:admin_client/models/models.dart';

abstract class TabServersEvent{}

class TabServersEventFetched extends TabServersEvent {}

class TabServersEventZoneList extends TabServersEvent {
  List<ZoneConfigRes> lst;

  TabServersEventZoneList(this.lst);

}

class TabServersEventGoToZone extends TabServersEvent {
  ZoneConfigRes res;

  TabServersEventGoToZone(this.res);

}
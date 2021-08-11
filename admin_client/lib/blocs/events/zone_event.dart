import 'package:equatable/equatable.dart';
import 'package:admin_client/models/models.dart';

abstract class ZoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ZoneEventFetched extends ZoneEvent {}

class ZoneEventGetUsers extends ZoneEvent {}

class ZoneEventUpdateUsers extends ZoneEvent {
  final List<UserRes> lst;

  ZoneEventUpdateUsers(this.lst);

  List<Object> get props => [lst];

}

class ZoneEventZoneInfo extends ZoneEvent {
  final ZoneRes res;
  final List<RoomRes> rooms;

  ZoneEventZoneInfo(this.res , this.rooms);

  List<Object> get props => [res, rooms];

}

class ZoneEventRoomChoose extends ZoneEvent {
  final RoomView room;

  ZoneEventRoomChoose(this.room);

  List<Object> get props => [room];

}

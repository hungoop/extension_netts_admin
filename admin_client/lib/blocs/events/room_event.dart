import 'package:equatable/equatable.dart';
import 'package:admin_client/models/models.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RoomEventFetched extends RoomEvent {}

class RoomEventUserList extends RoomEvent {
  final List<UserRes> lst;

  RoomEventUserList(this.lst);

  List<Object> get props => [lst];

}

class RoomEventOpenUser extends RoomEvent {
  final UserView userView;

  RoomEventOpenUser(this.userView);

  List<Object> get props => [userView];

}

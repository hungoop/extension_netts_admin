import 'package:equatable/equatable.dart';
import 'package:admin_client/models/models.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserEventFetched extends UserEvent {}

class UserEventUserList extends UserEvent {
  final List<UserRes> lst;

  UserEventUserList(this.lst);

  List<Object> get props => [lst];

}

class UserEventOpenUser extends UserEvent {
  final UserView userView;

  UserEventOpenUser(this.userView);

  List<Object> get props => [userView];

}

import 'package:equatable/equatable.dart';
import 'package:admin_client/models/models.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserEventFetched extends UserEvent {}

class UserEventDelete extends UserEvent {}

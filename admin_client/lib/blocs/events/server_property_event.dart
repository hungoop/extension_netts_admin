import 'package:admin_client/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ServerPropertyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerPropertyEventFetched extends ServerPropertyEvent {}

class ServerPropertyEventUpdate extends ServerPropertyEvent {
  final ServerProtocolRes res;

  ServerPropertyEventUpdate(this.res);

  @override
  List<Object> get props => [res];
}

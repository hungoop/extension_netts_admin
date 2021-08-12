import 'package:admin_client/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class ServerProtocolEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerProtocolEventFetched extends ServerProtocolEvent {}

class ServerProtocolEventUpdate extends ServerProtocolEvent {
  final List<ServerProtocolRes> resLst;

  ServerProtocolEventUpdate(this.resLst);

  @override
  List<Object> get props => [resLst];

}

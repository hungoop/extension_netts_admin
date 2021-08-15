import 'package:admin_client/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class BanManagerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BanManagerEventFetched extends BanManagerEvent {}

class BanManagerEventUpdate extends BanManagerEvent {
  final BanRes res;

  BanManagerEventUpdate(this.res);

  @override
  List<Object> get props => [res];

}

import 'package:admin_client/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class AccManagerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AccManagerEventFetched extends AccManagerEvent {}

class AccManagerEventUpdate extends AccManagerEvent {
  final List<AccountRes> lstAdminRes;

  AccManagerEventUpdate(this.lstAdminRes);

  @override
  List<Object> get props => [lstAdminRes];
}

import 'package:admin_client/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class RStatisticsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RStatisticsEventFetched extends RStatisticsEvent {}

class RStatisticsEventUpdate extends RStatisticsEvent {
  final RStatisticsRes res;

  RStatisticsEventUpdate(this.res);

  @override
  List<Object> get props => [res];

}

import 'package:equatable/equatable.dart';
import 'package:admin_client/models/models.dart';

abstract class ExtEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ExtEventFetched extends ExtEvent {}

class ExtEventUpdateRes extends ExtEvent {
  final ExtRes res;

  ExtEventUpdateRes(this.res);

  List<Object> get props => [res];

}

class ExtEventStop extends ExtEvent {}

class ExtEventStart extends ExtEvent {}

class ExtEventReload extends ExtEvent {}

import 'package:equatable/equatable.dart';
import 'package:rms_ui/common/models.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomFetch extends RoomEvent {
  RoomFetch();
}

class RoomCreate extends RoomEvent {
  final Room room;

  RoomCreate({required this.room});

  @override
  List<Object?> get props => [Room];
}

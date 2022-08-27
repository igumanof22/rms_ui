import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomFetch extends RoomEvent {
  RoomFetch();
}

class RoomGet extends RoomEvent {
  final String id;

  RoomGet({required this.id});

  @override
  List<Object?> get props => [id];
}

class RoomCreate extends RoomEvent {
  final Room room;

  RoomCreate({required this.room});

  @override
  List<Object?> get props => [room];
}

class RoomUpdate extends RoomEvent {
  final Room room;

  RoomUpdate({required this.room});

  @override
  List<Object?> get props => [room];
}

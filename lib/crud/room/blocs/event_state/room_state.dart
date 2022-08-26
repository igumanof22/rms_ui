import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomUninitialized extends RoomState {}

class RoomLoading extends RoomState {}

class RoomError extends RoomState {}

class RoomCreateSuccess extends RoomState {}

class RoomInitialized extends RoomState {
  final List<Room> listRoom;

  RoomInitialized({required this.listRoom});

  @override
  List<Object?> get props => [listRoom];
}

class RoomGetData extends RoomState {
  final Room room;

  RoomGetData({required this.room});

  @override
  List<Object?> get props => [room];
}

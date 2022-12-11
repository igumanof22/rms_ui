import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomUninitialized extends RoomState {}

class RoomLoading extends RoomState {}

class RoomError extends RoomState {}

class RoomSuccess extends RoomState {}

class RoomInitialized extends RoomState {
  final List<Room> listRoom;
  final int? nextPage;

  RoomInitialized({required this.listRoom, this.nextPage});

  @override
  List<Object?> get props => [listRoom, nextPage];
}

class RoomGetData extends RoomState {
  final Room room;

  RoomGetData({required this.room});

  @override
  List<Object?> get props => [room];
}

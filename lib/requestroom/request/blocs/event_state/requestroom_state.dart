import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomUninitialized extends RequestRoomState {}

class RequestRoomLoading extends RequestRoomState {}

class RequestRoomError extends RequestRoomState {}

class RequestRoomCreateSuccess extends RequestRoomState {}

class RequestRoomInitialized extends RequestRoomState {
  final List<RequestRoom> listRequestRoom;

  RequestRoomInitialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}

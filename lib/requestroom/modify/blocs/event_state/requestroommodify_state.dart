import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomModifyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomModifyUninitialized extends RequestRoomModifyState {}

class RequestRoomModifyLoading extends RequestRoomModifyState {}

class RequestRoomModifyError extends RequestRoomModifyState {}

class RequestRoomModifyCreateSuccess extends RequestRoomModifyState {}

class RequestRoomModifyInitialized extends RequestRoomModifyState {
  final List<RequestRoom> listRequestRoom;

  RequestRoomModifyInitialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}

import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomUninitialized extends RequestRoomState {}

class RequestRoomLoading extends RequestRoomState {}

class RequestRoomError extends RequestRoomState {}

class RequestRoomSuccess extends RequestRoomState {}

class RequestRoomLast extends RequestRoomState {}

class RequestRoomInitialized extends RequestRoomState {
  final List<RequestRoom> listRequestRoom;
  final int? nextPage;

  RequestRoomInitialized(
      {required this.listRequestRoom, required this.nextPage});

  @override
  List<Object?> get props => [listRequestRoom, nextPage];
}

class RequestRoomGetData extends RequestRoomState {
  final DetailRequestRoom detailRequestRoom;

  RequestRoomGetData({required this.detailRequestRoom});

  @override
  List<Object?> get props => [detailRequestRoom];
}

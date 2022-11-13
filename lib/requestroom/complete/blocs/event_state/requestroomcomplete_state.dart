import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomCompleteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomCompleteUninitialized extends RequestRoomCompleteState {}

class RequestRoomCompleteLoading extends RequestRoomCompleteState {}

class RequestRoomCompleteError extends RequestRoomCompleteState {}

class RequestRoomCompleteSuccess extends RequestRoomCompleteState {}

class RequestRoomCompleteInitialized extends RequestRoomCompleteState {
  final List<RequestRoom> listRequestRoom;

  RequestRoomCompleteInitialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}

class RequestRoomCompleteGetData extends RequestRoomCompleteState {
  final DetailRequestRoom detailRequestRoom;

  RequestRoomCompleteGetData({required this.detailRequestRoom});

  @override
  List<Object?> get props => [detailRequestRoom];
}

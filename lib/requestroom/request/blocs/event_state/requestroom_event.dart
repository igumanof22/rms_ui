import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomFetch extends RequestRoomEvent {
  RequestRoomFetch();
}

class RequestRoomCreate extends RequestRoomEvent {
  final RequestRoom requestRoom;

  RequestRoomCreate({required this.requestRoom});

  @override
  List<Object?> get props => [requestRoom];
}

class RequestRoomDraft extends RequestRoomEvent {
  final RequestRoomDrafts requestRoomDraft;

  RequestRoomDraft({required this.requestRoomDraft});

  @override
  List<Object?> get props => [requestRoomDraft];
}

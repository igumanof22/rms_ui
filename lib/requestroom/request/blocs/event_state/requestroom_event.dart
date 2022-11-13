import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomFetch extends RequestRoomEvent {
  RequestRoomFetch();
}

class RequestRoomGet extends RequestRoomEvent {
  final String id;

  RequestRoomGet(this.id);

  @override
  List<Object?> get props => [id];
}

class RequestRoomCreate extends RequestRoomEvent {
  final RequestRoom requestRoom;
  final String pictName;
  final String pictPath;

  RequestRoomCreate(
      {required this.requestRoom,
      required this.pictName,
      required this.pictPath});

  @override
  List<Object?> get props => [requestRoom, pictName, pictPath];
}

class RequestRoomDraft extends RequestRoomEvent {
  final RequestRoomDrafts requestRoomDraft;
  final String pictName;
  final String pictPath;

  RequestRoomDraft(
      {required this.requestRoomDraft,
      required this.pictName,
      required this.pictPath});

  @override
  List<Object?> get props => [requestRoomDraft, pictName, pictPath];
}

class RequestRoomDownload extends RequestRoomEvent {
  final String id;

  RequestRoomDownload(this.id);

  @override
  List<Object?> get props => [id];
}

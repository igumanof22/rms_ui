import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomFetch extends RequestRoomEvent {
  final String requestId;
  final int limit;
  final int page;

  RequestRoomFetch(
      {required this.requestId, required this.limit, required this.page});

  @override
  List<Object?> get props => [requestId, limit, page];
}

class RequestRoomGet extends RequestRoomEvent {
  final String id;

  RequestRoomGet({required this.id});

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

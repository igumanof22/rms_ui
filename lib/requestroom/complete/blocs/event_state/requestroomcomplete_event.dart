import 'package:equatable/equatable.dart';

abstract class RequestRoomCompleteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomCompleteFetch extends RequestRoomCompleteEvent {
  RequestRoomCompleteFetch();
}

class RequestRoomCompleteGet extends RequestRoomCompleteEvent {
  final String id;
  
  RequestRoomCompleteGet(this.id);
  
  @override
  List<Object?> get props => [id];
}

class RequestRoomCompleteSubmit extends RequestRoomCompleteEvent {
  final String id;
  final String requestId;
  final String fileName;
  final String filePath;

  RequestRoomCompleteSubmit(
      {required this.id, required this.requestId, required this.fileName, required this.filePath});

  @override
  List<Object?> get props => [id, requestId, fileName, filePath];
}

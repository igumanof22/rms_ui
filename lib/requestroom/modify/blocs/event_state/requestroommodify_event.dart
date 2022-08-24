import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomModifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomModifyFetch extends RequestRoomModifyEvent {
  RequestRoomModifyFetch();
}

class RequestRoomModifyCreate extends RequestRoomModifyEvent {
  final RequestRoom requestRoom;

  RequestRoomModifyCreate({required this.requestRoom});

  @override
  List<Object?> get props => [RequestRoom];
}

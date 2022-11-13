import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomModifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomModifyFetch extends RequestRoomModifyEvent {
  RequestRoomModifyFetch();
}

class RequestRoomModifySubmit extends RequestRoomModifyEvent {
  final RequestRoom requestRoom;
  final String pictName;
  final String pictPath;

  RequestRoomModifySubmit(
      {required this.requestRoom,
      required this.pictName,
      required this.pictPath});

  @override
  List<Object?> get props => [RequestRoom];
}

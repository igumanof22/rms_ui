import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomReviewL2Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL2Fetch extends RequestRoomReviewL2Event {
  RequestRoomReviewL2Fetch();
}

class RequestRoomReviewL2Create extends RequestRoomReviewL2Event {
  final RequestRoom requestRoom;

  RequestRoomReviewL2Create({required this.requestRoom});

  @override
  List<Object?> get props => [RequestRoom];
}

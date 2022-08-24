import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomReviewL1Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL1Fetch extends RequestRoomReviewL1Event {
  RequestRoomReviewL1Fetch();
}

class RequestRoomReviewL1Create extends RequestRoomReviewL1Event {
  final RequestRoom requestRoom;

  RequestRoomReviewL1Create({required this.requestRoom});

  @override
  List<Object?> get props => [RequestRoom];
}

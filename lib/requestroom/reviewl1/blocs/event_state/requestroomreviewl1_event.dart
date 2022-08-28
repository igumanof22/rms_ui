import 'package:equatable/equatable.dart';

abstract class RequestRoomReviewL1Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL1Fetch extends RequestRoomReviewL1Event {
  RequestRoomReviewL1Fetch();
}

class RequestRoomReviewL1Submit extends RequestRoomReviewL1Event {
  final String id;
  final String requestId;
  final bool decision;
  final String? reason;

  RequestRoomReviewL1Submit(
      {required this.id, required this.requestId, required this.decision, this.reason});

  @override
  List<Object?> get props => [id, requestId, decision, reason];
}

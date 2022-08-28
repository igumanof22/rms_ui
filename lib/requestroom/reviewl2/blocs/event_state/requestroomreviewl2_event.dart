import 'package:equatable/equatable.dart';

abstract class RequestRoomReviewL2Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL2Fetch extends RequestRoomReviewL2Event {
  RequestRoomReviewL2Fetch();
}

class RequestRoomReviewL2Get extends RequestRoomReviewL2Event {
  final String id;
  
  RequestRoomReviewL2Get(this.id);
  
  @override
  List<Object?> get props => [id];
}

class RequestRoomReviewL2Submit extends RequestRoomReviewL2Event {
  final String id;
  final String requestId;
  final bool decision;
  final String? reason;

  RequestRoomReviewL2Submit(
      {required this.id, required this.requestId, required this.decision, this.reason});

  @override
  List<Object?> get props => [id, requestId, decision, reason];
}

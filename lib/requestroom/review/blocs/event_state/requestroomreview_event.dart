import 'package:equatable/equatable.dart';

abstract class RequestRoomReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewFetch extends RequestRoomReviewEvent {
  final String requestId;
  
  RequestRoomReviewFetch({required this.requestId});
  
  @override
  List<Object?> get props => [requestId];
}

class RequestRoomReviewGet extends RequestRoomReviewEvent {
  final String id;
  
  RequestRoomReviewGet({required this.id});
  
  @override
  List<Object?> get props => [id];
}

class RequestRoomReviewSubmit extends RequestRoomReviewEvent {
  final String id;
  final String requestId;
  final bool decision;
  final String? reason;

  RequestRoomReviewSubmit(
      {required this.id, required this.requestId, required this.decision, this.reason});

  @override
  List<Object?> get props => [id, requestId, decision, reason];
}

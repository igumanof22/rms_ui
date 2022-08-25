import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomReviewL1State extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL1Uninitialized extends RequestRoomReviewL1State {}

class RequestRoomReviewL1Loading extends RequestRoomReviewL1State {}

class RequestRoomReviewL1Error extends RequestRoomReviewL1State {}

class RequestRoomReviewL1CreateSuccess extends RequestRoomReviewL1State {}

class RequestRoomReviewL1Initialized extends RequestRoomReviewL1State {
  final List<RequestRoom> listRequestRoom;

  RequestRoomReviewL1Initialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}
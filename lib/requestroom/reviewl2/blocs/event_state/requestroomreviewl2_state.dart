import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomReviewL2State extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewL2Uninitialized extends RequestRoomReviewL2State {}

class RequestRoomReviewL2Loading extends RequestRoomReviewL2State {}

class RequestRoomReviewL2Error extends RequestRoomReviewL2State {}

class RequestRoomReviewL2CreateSuccess extends RequestRoomReviewL2State {}

class RequestRoomReviewL2Initialized extends RequestRoomReviewL2State {
  final List<RequestRoom> listRequestRoom;

  RequestRoomReviewL2Initialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}

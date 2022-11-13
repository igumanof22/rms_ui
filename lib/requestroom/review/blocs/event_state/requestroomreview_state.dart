import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class RequestRoomReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestRoomReviewUninitialized extends RequestRoomReviewState {}

class RequestRoomReviewLoading extends RequestRoomReviewState {}

class RequestRoomReviewError extends RequestRoomReviewState {}

class RequestRoomReviewSuccess extends RequestRoomReviewState {}

class RequestRoomReviewInitialized extends RequestRoomReviewState {
  final List<RequestRoom> listRequestRoom;

  RequestRoomReviewInitialized({required this.listRequestRoom});

  @override
  List<Object?> get props => [listRequestRoom];
}

class RequestRoomReviewGetData extends RequestRoomReviewState {
  final DetailRequestRoom detailRequestRoom;

  RequestRoomReviewGetData({required this.detailRequestRoom});

  @override
  List<Object?> get props => [detailRequestRoom];
}

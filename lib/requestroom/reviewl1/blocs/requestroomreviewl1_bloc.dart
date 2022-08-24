import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomReviewL1Bloc extends Bloc<RequestRoomReviewL1Event, RequestRoomReviewL1State> {
  RequestRoomReviewL1Bloc() : super(RequestRoomReviewL1Uninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(
      RequestRoomReviewL1Fetch event, Emitter<RequestRoomReviewL1State> emit) async {
    try {
      emit(RequestRoomReviewL1Loading());

      List<RequestRoom> listRequestRoom = await RequestRoomReviewL1Service.fetch();

      emit(RequestRoomReviewL1Initialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL1Bloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoomReviewL1', isError: true);

      emit(RequestRoomReviewL1Error());
    }
  }

  Future<void> _onCreate(
      RequestRoomReviewL1Create event, Emitter<RequestRoomReviewL1State> emit) async {
    try {
      emit(RequestRoomReviewL1Loading());

      await RequestRoomReviewL1Service.create(event.requestRoom);

      showSnackbar('Sukses tambah RequestRoomReviewL1');

      emit(RequestRoomReviewL1CreateSuccess());

      add(RequestRoomReviewL1Fetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL1Bloc - _onCreate');

      showSnackbar('Gagal tambah RequestRoomReviewL1', isError: true);

      emit(RequestRoomReviewL1Error());
    }
  }
}

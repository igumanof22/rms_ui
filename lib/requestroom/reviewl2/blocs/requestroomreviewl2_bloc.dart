import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomReviewL2Bloc extends Bloc<RequestRoomReviewL2Event, RequestRoomReviewL2State> {
  RequestRoomReviewL2Bloc() : super(RequestRoomReviewL2Uninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(
      RequestRoomReviewL2Fetch event, Emitter<RequestRoomReviewL2State> emit) async {
    try {
      emit(RequestRoomReviewL2Loading());

      List<RequestRoom> listRequestRoom = await RequestRoomReviewL2Service.fetch();

      emit(RequestRoomReviewL2Initialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL2Bloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoomReviewL2', isError: true);

      emit(RequestRoomReviewL2Error());
    }
  }

  Future<void> _onCreate(
      RequestRoomReviewL2Create event, Emitter<RequestRoomReviewL2State> emit) async {
    try {
      emit(RequestRoomReviewL2Loading());

      await RequestRoomReviewL2Service.create(event.requestRoom);

      showSnackbar('Sukses tambah RequestRoomReviewL2');

      emit(RequestRoomReviewL2CreateSuccess());

      add(RequestRoomReviewL2Fetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL2Bloc - _onCreate');

      showSnackbar('Gagal tambah RequestRoomReviewL2', isError: true);

      emit(RequestRoomReviewL2Error());
    }
  }
}

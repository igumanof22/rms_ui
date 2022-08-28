import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomReviewL1Bloc
    extends Bloc<RequestRoomReviewL1Event, RequestRoomReviewL1State> {
  RequestRoomReviewL1Bloc() : super(RequestRoomReviewL1Uninitialized()) {
    on(_onSubmit);
    on(_onFetch);
  }

  Future<void> _onFetch(RequestRoomReviewL1Fetch event,
      Emitter<RequestRoomReviewL1State> emit) async {
    try {
      emit(RequestRoomReviewL1Loading());

      List<RequestRoom> listRequestRoom =
          await RequestRoomReviewL1Service.fetch();

      emit(RequestRoomReviewL1Initialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL1Bloc - _onFetch');

      showSnackbar('Gagal ambil data Request', isError: true);

      emit(RequestRoomReviewL1Error());
    }
  }

  Future<void> _onSubmit(RequestRoomReviewL1Submit event,
      Emitter<RequestRoomReviewL1State> emit) async {
    try {
      emit(RequestRoomReviewL1Loading());

      await RequestRoomReviewL1Service.submit(
          event.id, event.decision, event.reason);

      if (event.decision == true) {
        showSnackbar('Sukses Menyetujui Request ${event.requestId}');
      } else {
        showSnackbar('Sukses Menolak Request ${event.requestId}');
      }

      emit(RequestRoomReviewL1Success());

      add(RequestRoomReviewL1Fetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL1Bloc - _onCreate');

      if (event.decision == true) {
        showSnackbar('Gagal Menyetujui Request ${event.requestId}',
            isError: true);
      } else {
        showSnackbar('Gagal Menolak Request ${event.requestId}', isError: true);
      }

      emit(RequestRoomReviewL1Error());
      rethrow;
    }
  }
}

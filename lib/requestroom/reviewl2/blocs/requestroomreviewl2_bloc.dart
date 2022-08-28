import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomReviewL2Bloc
    extends Bloc<RequestRoomReviewL2Event, RequestRoomReviewL2State> {
  RequestRoomReviewL2Bloc() : super(RequestRoomReviewL2Uninitialized()) {
    on(_onSubmit);
    on(_onFetch);
    on(_onGet);
  }

  Future<void> _onFetch(RequestRoomReviewL2Fetch event,
      Emitter<RequestRoomReviewL2State> emit) async {
    try {
      emit(RequestRoomReviewL2Loading());

      List<RequestRoom> listRequestRoom =
          await RequestRoomReviewL2Service.fetch();

      emit(RequestRoomReviewL2Initialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL2Bloc - _onFetch');

      showSnackbar('Gagal ambil data Request', isError: true);

      emit(RequestRoomReviewL2Error());
    }
  }

      Future<void> _onGet(
      RequestRoomReviewL2Get event, Emitter<RequestRoomReviewL2State> emit) async {
    try {
      emit(RequestRoomReviewL2Loading());

      DetailRequestRoom detailRequestRoom =
          await RequestRoomReviewL2Service.getData(event.id);

      emit(RequestRoomReviewL2GetData(detailRequestRoom: detailRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoom', isError: true);

      emit(RequestRoomReviewL2Error());
      rethrow;
    }
  }

  Future<void> _onSubmit(RequestRoomReviewL2Submit event,
      Emitter<RequestRoomReviewL2State> emit) async {
    try {
      emit(RequestRoomReviewL2Loading());

      await RequestRoomReviewL2Service.submit(
          event.id, event.decision, event.reason);

      if (event.decision == true) {
        showSnackbar('Sukses Menyetujui Request ${event.requestId}');
      } else {
        showSnackbar('Sukses Menolak Request ${event.requestId}');
      }

      emit(RequestRoomReviewL2Success());

      add(RequestRoomReviewL2Fetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewL2Bloc - _onCreate');

      if (event.decision == true) {
        showSnackbar('Gagal Menyetujui Request ${event.requestId}',
            isError: true);
      } else {
        showSnackbar('Gagal Menolak Request ${event.requestId}', isError: true);
      }

      emit(RequestRoomReviewL2Error());
      rethrow;
    }
  }
}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomReviewBloc
    extends Bloc<RequestRoomReviewEvent, RequestRoomReviewState> {
  RequestRoomReviewBloc() : super(RequestRoomReviewUninitialized()) {
    on(_onSubmit);
    on(_onFetch);
    on(_onGet);
  }

  Future<void> _onFetch(RequestRoomReviewFetch event,
      Emitter<RequestRoomReviewState> emit) async {
    try {
      emit(RequestRoomReviewLoading());

      List<RequestRoom> listRequestRoom =
          await RequestRoomReviewService.fetch(event.requestId);

      emit(RequestRoomReviewInitialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewBloc - _onFetch');

      showSnackbar('Gagal ambil data Request', isError: true);

      emit(RequestRoomReviewError());
    }
  }

    Future<void> _onGet(
      RequestRoomReviewGet event, Emitter<RequestRoomReviewState> emit) async {
    try {
      emit(RequestRoomReviewLoading());

      DetailRequestRoom detailRequestRoom =
          await RequestRoomReviewService.getData(event.id);

      emit(RequestRoomReviewGetData(detailRequestRoom: detailRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoom', isError: true);

      emit(RequestRoomReviewError());
      rethrow;
    }
  }

  Future<void> _onSubmit(RequestRoomReviewSubmit event,
      Emitter<RequestRoomReviewState> emit) async {
    try {
      emit(RequestRoomReviewLoading());

      await RequestRoomReviewService.submit(
          event.id, event.decision, event.reason);

      if (event.decision == true) {
        showSnackbar('Sukses Menyetujui Request ${event.requestId}');
      } else {
        showSnackbar('Sukses Menolak Request ${event.requestId}');
      }

      emit(RequestRoomReviewSuccess());

      add(RequestRoomReviewFetch(requestId: ''));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomReviewBloc - _onCreate');

      if (event.decision == true) {
        showSnackbar('Gagal Menyetujui Request ${event.requestId}',
            isError: true);
      } else {
        showSnackbar('Gagal Menolak Request ${event.requestId}', isError: true);
      }

      emit(RequestRoomReviewError());
      rethrow;
    }
  }
}

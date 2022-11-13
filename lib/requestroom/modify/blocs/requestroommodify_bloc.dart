import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomModifyBloc
    extends Bloc<RequestRoomModifyEvent, RequestRoomModifyState> {
  RequestRoomModifyBloc() : super(RequestRoomModifyUninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(RequestRoomModifyFetch event,
      Emitter<RequestRoomModifyState> emit) async {
    try {
      emit(RequestRoomModifyLoading());

      List<RequestRoom> listRequestRoom =
          await RequestRoomModifyService.fetch();

      emit(RequestRoomModifyInitialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomModifyBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoomModify', isError: true);

      emit(RequestRoomModifyError());
    }
  }

  Future<void> _onCreate(RequestRoomModifySubmit event,
      Emitter<RequestRoomModifyState> emit) async {
    try {
      emit(RequestRoomModifyLoading());

      await RequestRoomModifyService.submit(
          event.requestRoom, event.pictName, event.pictPath);

      showSnackbar('Sukses tambah RequestRoomModify');

      emit(RequestRoomModifyCreateSuccess());

      add(RequestRoomModifyFetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomModifyBloc - _onCreate');

      showSnackbar('Gagal tambah RequestRoomModify', isError: true);

      emit(RequestRoomModifyError());
    }
  }
}

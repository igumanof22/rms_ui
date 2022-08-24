import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomBloc extends Bloc<RequestRoomEvent, RequestRoomState> {
  RequestRoomBloc() : super(RequestRoomUninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(
      RequestRoomFetch event, Emitter<RequestRoomState> emit) async {
    try {
      emit(RequestRoomLoading());

      List<RequestRoom> listRequestRoom = await RequestRoomService.fetch();

      emit(RequestRoomInitialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoom', isError: true);

      emit(RequestRoomError());
    }
  }

  Future<void> _onCreate(
      RequestRoomCreate event, Emitter<RequestRoomState> emit) async {
    try {
      emit(RequestRoomLoading());

      await RequestRoomService.create(event.requestRoom);

      showSnackbar('Sukses tambah RequestRoom');

      emit(RequestRoomCreateSuccess());

      add(RequestRoomFetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onCreate');

      showSnackbar('Gagal tambah RequestRoom', isError: true);

      emit(RequestRoomError());
    }
  }
}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomUninitialized()) {
    on(_onCreate);
    on(_onFetch);
    on(_onGet);
  }

  Future<void> _onFetch(RoomFetch event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      List<Room> listRoom = await RoomService.fetch();

      emit(RoomInitialized(listRoom: listRoom));
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onFetch');

      showSnackbar('Gagal ambil Room', isError: true);

      emit(RoomError());
    }
  }

  Future<void> _onGet(RoomGet event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      Room room = await RoomService.get(event.id);

      emit(RoomGetData(room: room));
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onGet');

      showSnackbar('Gagal ambil Room', isError: true);

      emit(RoomError());
    }
  }

  Future<void> _onCreate(RoomCreate event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      await RoomService.create(event.room);

      showSnackbar('Sukses tambah Room');

      emit(RoomCreateSuccess());

      add(RoomFetch());
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onCreate');

      showSnackbar('Gagal tambah Room', isError: true);

      emit(RoomError());
    }
  }
}

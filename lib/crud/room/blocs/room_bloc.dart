import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final List<Room> _list = [];
  RoomBloc() : super(RoomUninitialized()) {
    on(_onCreate);
    on(_onUpdate);
    on(_onFetch);
    on(_onGet);
  }

  Future<void> _onFetch(RoomFetch event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      int currentPage = event.page;
      int? nextPage = currentPage + 1;
      List<Room> listRoom =
          await RoomService.fetch(event.roomId, event.limit, nextPage);

      _list.addAll(listRoom);

      if (listRoom.isEmpty) {
        nextPage = null;
      }

      emit(RoomInitialized(listRoom: listRoom, nextPage: nextPage));
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onFetch');

      showSnackbar('Gagal ambil Room', isError: true);

      emit(RoomError());
      rethrow;
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

      emit(RoomSuccess());

      add(RoomFetch(roomId: '', limit: 20, page: 0));
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onCreate');

      showSnackbar('Gagal tambah Room', isError: true);

      emit(RoomError());
      rethrow;
    }
  }

  Future<void> _onUpdate(RoomUpdate event, Emitter<RoomState> emit) async {
    try {
      emit(RoomLoading());

      await RoomService.update(event.room);

      showSnackbar('Sukses ubah ruangan');

      emit(RoomSuccess());

      add(RoomFetch(roomId: '', limit: 20, page: 0));
    } catch (e) {
      log(e.toString(), name: 'RoomBloc - _onUpdate');

      showSnackbar('Gagal ubah ruangan', isError: true);

      emit(RoomError());
      rethrow;
    }
  }
}

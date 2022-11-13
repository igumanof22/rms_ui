import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomBloc extends Bloc<RequestRoomEvent, RequestRoomState> {
  RequestRoomBloc() : super(RequestRoomUninitialized()) {
    on(_onSubmit);
    on(_onDraft);
    on(_onFetch);
    on(_onGet);
    on(_onDownload);
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
      rethrow;
    }
  }

  Future<void> _onGet(
      RequestRoomGet event, Emitter<RequestRoomState> emit) async {
    try {
      emit(RequestRoomLoading());

      DetailRequestRoom detailRequestRoom =
          await RequestRoomService.getData(event.id);

      emit(RequestRoomGetData(detailRequestRoom: detailRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoom', isError: true);

      emit(RequestRoomError());
      rethrow;
    }
  }

  Future<void> _onSubmit(
      RequestRoomCreate event, Emitter<RequestRoomState> emit) async {
    try {
      emit(RequestRoomLoading());

      await RequestRoomService.create(
          event.requestRoom, event.pictName, event.pictPath);

      showSnackbar('Sukses Mengajukan Request');

      emit(RequestRoomSuccess());

      add(RequestRoomFetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onSubmit');

      showSnackbar('Gagal Mengajukan Request', isError: true);

      emit(RequestRoomError());
      rethrow;
    }
  }

  Future<void> _onDraft(
      RequestRoomDraft event, Emitter<RequestRoomState> emit) async {
    try {
      emit(RequestRoomLoading());

      await RequestRoomService.draft(
          event.requestRoomDraft, event.pictName, event.pictPath);

      showSnackbar('Sukses Menyimpan Request');

      emit(RequestRoomSuccess());

      add(RequestRoomFetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onDraft');

      showSnackbar('Gagal Menyimpan Request', isError: true);

      emit(RequestRoomError());
      rethrow;
    }
  }

  Future<void> _onDownload(
      RequestRoomDownload event, Emitter<RequestRoomState> emit) async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      if (statuses[Permission.storage]!.isGranted) {
        emit(RequestRoomLoading());

        await RequestRoomService.download(event.id);

        emit(RequestRoomSuccess());
      } else {
        showSnackbar("No permission to read and write.", isError: true);
      }
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onDownload');

      showSnackbar('Gagal download dokument', isError: true);

      emit(RequestRoomError());
      rethrow;
    }
  }
}

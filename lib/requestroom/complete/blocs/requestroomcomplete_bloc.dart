import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class RequestRoomCompleteBloc
    extends Bloc<RequestRoomCompleteEvent, RequestRoomCompleteState> {
  RequestRoomCompleteBloc() : super(RequestRoomCompleteUninitialized()) {
    on(_onSubmit);
    on(_onFetch);
    on(_onGet);
  }

  Future<void> _onFetch(RequestRoomCompleteFetch event,
      Emitter<RequestRoomCompleteState> emit) async {
    try {
      emit(RequestRoomCompleteLoading());

      List<RequestRoom> listRequestRoom =
          await RequestRoomCompleteService.fetch();

      emit(RequestRoomCompleteInitialized(listRequestRoom: listRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomCompleteBloc - _onFetch');

      showSnackbar('Gagal ambil data Request', isError: true);

      emit(RequestRoomCompleteError());
    }
  }

  Future<void> _onGet(RequestRoomCompleteGet event,
      Emitter<RequestRoomCompleteState> emit) async {
    try {
      emit(RequestRoomCompleteLoading());

      DetailRequestRoom detailRequestRoom =
          await RequestRoomCompleteService.getData(event.id);

      emit(RequestRoomCompleteGetData(detailRequestRoom: detailRequestRoom));
    } catch (e) {
      log(e.toString(), name: 'RequestRoomBloc - _onFetch');

      showSnackbar('Gagal ambil RequestRoom', isError: true);

      emit(RequestRoomCompleteError());
      rethrow;
    }
  }

  Future<void> _onSubmit(RequestRoomCompleteSubmit event,
      Emitter<RequestRoomCompleteState> emit) async {
    try {
      emit(RequestRoomCompleteLoading());

      await RequestRoomCompleteService.submit(
          event.id, event.fileName, event.filePath);

      showSnackbar('Sukses Submit Request ${event.requestId}');

      emit(RequestRoomCompleteSuccess());

      add(RequestRoomCompleteFetch());
    } catch (e) {
      log(e.toString(), name: 'RequestRoomCompleteBloc - _onCreate');

      showSnackbar('Gagal Submit Request ${event.requestId}', isError: true);

      emit(RequestRoomCompleteError());
      rethrow;
    }
  }
}

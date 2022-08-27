import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/crud/furniture/furniture.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  FurnitureBloc() : super(FurnitureUninitialized()) {
    on(_onCreate);
    on(_onUpdate);
    on(_onFetch);
    on(_onGet);
    on(_onDelete);
  }

  Future<void> _onFetch(
      FurnitureFetch event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      List<Furniture> listFurniture = await FurnitureService.fetch();

      emit(FurnitureInitialized(listFurniture: listFurniture));
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onFetch');

      showSnackbar('Gagal ambil Furniture', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }

  Future<void> _onGet(FurnitureGet event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      Furniture furniture = await FurnitureService.get(event.id);

      emit(FurnitureGetData(furniture: furniture));
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onGet');

      showSnackbar('Gagal ambil Furniture', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }

  Future<void> _onCreate(
      FurnitureCreate event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      await FurnitureService.create(event.furniture);

      showSnackbar('Sukses tambah Furnitur');

      emit(FurnitureSuccess());
      add(FurnitureFetch());
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onCreate');

      showSnackbar('Gagal tambah Furnitur', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }

  Future<void> _onUpdate(
      FurnitureUpdate event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      await FurnitureService.update(event.id, event.furniture);

      showSnackbar('Sukses ubah Furnitur');

      emit(FurnitureSuccess());
      add(FurnitureFetch());
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onUpdate');

      showSnackbar('Gagal ubah Furnitur', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }

  Future<void> _onDelete(
      FurnitureDelete event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      await FurnitureService.delete(event.id);

      showSnackbar('Sukses hapus Furnitur');

      emit(FurnitureSuccess());

      add(FurnitureFetch());
      add(FurnitureFetch());
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onDelete');

      showSnackbar('Gagal hapus Furnitur', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }
}

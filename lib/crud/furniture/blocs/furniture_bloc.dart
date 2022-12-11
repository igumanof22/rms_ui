import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/crud/furniture/furniture.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  final List<Furniture> _list = [];
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

      int currentPage = event.page;
      int? nextPage = currentPage + 1;
      List<Furniture> listFurniture =
          await FurnitureService.fetch(event.name, event.limit, currentPage);

      _list.addAll(listFurniture);

      if (listFurniture.isEmpty) {
        nextPage = null;
      }

      emit(FurnitureInitialized(listFurniture: listFurniture, nextPage: nextPage));
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
      add(FurnitureFetch(name: '', limit: 20, page: 0));
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
      add(FurnitureFetch(name: '', limit: 20, page: 0));
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

      add(FurnitureFetch(name: '', limit: 20, page: 0));
      add(FurnitureFetch(name: '', limit: 20, page: 0));
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onDelete');

      showSnackbar('Gagal hapus Furnitur', isError: true);

      emit(FurnitureError());
      rethrow;
    }
  }
}

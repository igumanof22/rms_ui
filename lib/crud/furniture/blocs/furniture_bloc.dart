import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/common/blocs.dart';
import 'package:rms_ui/crud/furniture/furniture.dart';
import 'package:rms_ui/common/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  FurnitureBloc() : super(FurnitureUninitialized()) {
    on(_onCreate);
    on(_onFetch);
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
    }
  }

  Future<void> _onCreate(
      FurnitureCreate event, Emitter<FurnitureState> emit) async {
    try {
      emit(FurnitureLoading());

      await FurnitureService.create(event.furniture);

      showSnackbar('Sukses tambah Furniture');

      emit(FurnitureCreateSuccess());

      add(FurnitureFetch());
    } catch (e) {
      log(e.toString(), name: 'FurnitureBloc - _onCreate');

      showSnackbar('Gagal tambah Furniture', isError: true);

      emit(FurnitureError());
    }
  }
}

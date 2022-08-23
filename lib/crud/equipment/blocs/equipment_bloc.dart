import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/common/blocs.dart';
import 'package:rms_ui/crud/equipment/equipment.dart';
import 'package:rms_ui/common/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc() : super(EquipmentUninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(
      EquipmentFetch event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      List<Equipment> listEquipment = await EquipmentService.fetch();

      emit(EquipmentInitialized(listEquipment: listEquipment));
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onFetch');

      showSnackbar('Gagal ambil Equipment', isError: true);

      emit(EquipmentError());
    }
  }

  Future<void> _onCreate(
      EquipmentCreate event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      await EquipmentService.create(event.equipment);

      showSnackbar('Sukses tambah Equipment');

      emit(EquipmentCreateSuccess());

      add(EquipmentFetch());
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onCreate');

      showSnackbar('Gagal tambah Equipment', isError: true);

      emit(EquipmentError());
    }
  }
}

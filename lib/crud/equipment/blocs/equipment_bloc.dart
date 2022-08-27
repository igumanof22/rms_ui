import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/crud/equipment/equipment.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc() : super(EquipmentUninitialized()) {
    on(_onCreate);
    on(_onUpdate);
    on(_onFetch);
    on(_onGetData);
    on(_onDelete);
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

  Future<void> _onGetData(
      EquipmentGet event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      Equipment equipment = await EquipmentService.get(event.id);

      emit(EquipmentGetData(equipment: equipment));
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onGet');

      showSnackbar('Gagal ambil Data Equipment', isError: true);

      emit(EquipmentError());
    }
  }

  Future<void> _onCreate(
      EquipmentCreate event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      await EquipmentService.create(event.equipment);

      showSnackbar('Sukses tambah peralatan');

      emit(EquipmentSuccess());
      add(EquipmentFetch());
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onCreate');

      showSnackbar('Gagal tambah peralatan', isError: true);

      emit(EquipmentError());
    }
  }

  Future<void> _onUpdate(
      EquipmentUpdate event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      await EquipmentService.update(event.id, event.equipment);

      showSnackbar('Sukses ubah peralatan');

      emit(EquipmentSuccess());
      add(EquipmentFetch());
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onUpdate');

      showSnackbar('Gagal ubah peralatan', isError: true);

      emit(EquipmentError());
    }
  }

  Future<void> _onDelete(
      EquipmentDelete event, Emitter<EquipmentState> emit) async {
    try {
      emit(EquipmentLoading());

      await EquipmentService.delete(event.id);

      showSnackbar('Sukses hapus peralatan');

      emit(EquipmentSuccess());
      add(EquipmentFetch());
    } catch (e) {
      log(e.toString(), name: 'EquipmentBloc - _onUpdate');

      showSnackbar('Gagal hapus peralatan', isError: true);

      emit(EquipmentError());
    }
  }
}

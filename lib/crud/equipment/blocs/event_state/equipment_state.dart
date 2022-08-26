import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class EquipmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EquipmentUninitialized extends EquipmentState {}

class EquipmentLoading extends EquipmentState {}

class EquipmentError extends EquipmentState {}

class EquipmentSuccess extends EquipmentState {}

class EquipmentInitialized extends EquipmentState {
  final List<Equipment> listEquipment;

  EquipmentInitialized({required this.listEquipment});

  @override
  List<Object?> get props => [listEquipment];
}

class EquipmentGetData extends EquipmentState {
  final Equipment equipment;

  EquipmentGetData({required this.equipment});

  @override
  List<Object?> get props => [equipment];
}

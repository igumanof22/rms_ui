import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class EquipmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EquipmentFetch extends EquipmentEvent {
  EquipmentFetch();
}

class EquipmentGet extends EquipmentEvent {
  final String id;
  EquipmentGet({required this.id});

  @override
  List<Object?> get props => [id];
}

class EquipmentCreate extends EquipmentEvent {
  final Equipment equipment;
  EquipmentCreate({required this.equipment});

  @override
  List<Object?> get props => [equipment];
}

class EquipmentUpdate extends EquipmentEvent {
  final Equipment equipment;
  final String id;
  EquipmentUpdate({required this.id, required this.equipment});

  @override
  List<Object?> get props => [equipment];
}

class EquipmentDelete extends EquipmentEvent {
  final String id;
  EquipmentDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

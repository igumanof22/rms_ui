import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class EquipmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EquipmentFetch extends EquipmentEvent {
  EquipmentFetch();
}

class EquipmentCreate extends EquipmentEvent {
  final Equipment equipment;

  EquipmentCreate({required this.equipment});

  @override
  List<Object?> get props => [Equipment];
}

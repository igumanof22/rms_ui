import 'package:equatable/equatable.dart';
import 'package:rms_ui/common/models.dart';

abstract class FurnitureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FurnitureUninitialized extends FurnitureState {}

class FurnitureLoading extends FurnitureState {}

class FurnitureError extends FurnitureState {}

class FurnitureCreateSuccess extends FurnitureState {}

class FurnitureInitialized extends FurnitureState {
  final List<Furniture> listFurniture;

  FurnitureInitialized({required this.listFurniture});

  @override
  List<Object?> get props => [listFurniture];
}

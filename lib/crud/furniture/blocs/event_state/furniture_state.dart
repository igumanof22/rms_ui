import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class FurnitureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FurnitureUninitialized extends FurnitureState {}

class FurnitureLoading extends FurnitureState {}

class FurnitureError extends FurnitureState {}

class FurnitureSuccess extends FurnitureState {}

class FurnitureInitialized extends FurnitureState {
  final List<Furniture> listFurniture;
  final int? nextPage;

  FurnitureInitialized({required this.listFurniture, this.nextPage});

  @override
  List<Object?> get props => [listFurniture, nextPage];
}

class FurnitureGetData extends FurnitureState {
  final Furniture furniture;

  FurnitureGetData({required this.furniture});

  @override
  List<Object?> get props => [furniture];
}

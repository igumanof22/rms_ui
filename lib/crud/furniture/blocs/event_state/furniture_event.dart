import 'package:equatable/equatable.dart';
import 'package:rms_ui/common/models.dart';

abstract class FurnitureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FurnitureFetch extends FurnitureEvent {
  FurnitureFetch();
}

class FurnitureCreate extends FurnitureEvent {
  final Furniture furniture;

  FurnitureCreate({required this.furniture});

  @override
  List<Object?> get props => [Furniture];
}

import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class FurnitureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FurnitureFetch extends FurnitureEvent {
  final String name;
  final int limit;
  final int page;

  FurnitureFetch({required this.name, required this.limit, required this.page});

  @override
  List<Object?> get props => [name, limit, page];
}

class FurnitureGet extends FurnitureEvent {
  final String id;

  FurnitureGet({required this.id});

  @override
  List<Object?> get props => [id];
}

class FurnitureCreate extends FurnitureEvent {
  final Furniture furniture;

  FurnitureCreate({required this.furniture});

  @override
  List<Object?> get props => [furniture];
}

class FurnitureUpdate extends FurnitureEvent {
  final String id;
  final Furniture furniture;

  FurnitureUpdate({required this.id, required this.furniture});

  @override
  List<Object?> get props => [id, furniture];
}

class FurnitureDelete extends FurnitureEvent {
  final String id;
  FurnitureDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersUninitialized extends UsersState {}

class UsersLoading extends UsersState {}

class UsersError extends UsersState {}

class UsersCreateSuccess extends UsersState {}

class UsersInitialized extends UsersState {
  final List<Users> listUsers;

  UsersInitialized({required this.listUsers});

  @override
  List<Object?> get props => [listUsers];
}

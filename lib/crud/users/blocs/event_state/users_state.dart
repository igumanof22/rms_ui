import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersUninitialized extends UsersState {}

class UsersLoading extends UsersState {}

class UsersError extends UsersState {}

class UsersSuccess extends UsersState {}

class UsersInitialized extends UsersState {
  final List<Users> listUsers;
  final int? nextPage;

  UsersInitialized({required this.listUsers, this.nextPage});

  @override
  List<Object?> get props => [listUsers, nextPage];
}

class UsersGetData extends UsersState {
  final Users users;

  UsersGetData({required this.users});

  @override
  List<Object?> get props => [users];
}

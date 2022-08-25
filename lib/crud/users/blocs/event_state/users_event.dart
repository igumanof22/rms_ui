import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersFetch extends UsersEvent {
  UsersFetch();
}

class UsersCreate extends UsersEvent {
  final Users users;

  UsersCreate({required this.users});

  @override
  List<Object?> get props => [Users];
}

class UsersLogin extends UsersEvent {
  final String username;
  final String password;

  UsersLogin({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

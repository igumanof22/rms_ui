import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersFetch extends UsersEvent {
  final String name;
  final int limit;
  final int page;

  UsersFetch({required this.name, required this.limit, required this.page});

  @override
  List<Object?> get props => [name, limit, page];
}

class UsersGet extends UsersEvent {
  final String id;

  UsersGet({required this.id});

  @override
  List<Object?> get props => [id];
}

class UsersCreate extends UsersEvent {
  final Users users;

  UsersCreate({required this.users});

  @override
  List<Object?> get props => [users];
}

class UsersProfile extends UsersEvent {
  final String id;
  final UsersProfileModel profileModel;

  UsersProfile({required this.id, required this.profileModel});

  @override
  List<Object?> get props => [id, profileModel];
}

class UsersSignUp extends UsersEvent {
  final UsersSignUpModel signUpModel;

  UsersSignUp({required this.signUpModel});

  @override
  List<Object?> get props => [signUpModel];
}

class UsersLogin extends UsersEvent {
  final String username;
  final String password;

  UsersLogin({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

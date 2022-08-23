import 'package:equatable/equatable.dart';
import 'package:rms_ui/common/models.dart';

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

import 'package:equatable/equatable.dart';
import 'package:rms_ui/barrel/models.dart';

abstract class ActivityLevelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityLevelUninitialized extends ActivityLevelState {}

class ActivityLevelLoading extends ActivityLevelState {}

class ActivityLevelError extends ActivityLevelState {}

class ActivityLevelInitialized extends ActivityLevelState {
  final List<ActivityLevel> listActivityLevel;

  ActivityLevelInitialized({required this.listActivityLevel});

  @override
  List<Object?> get props => [listActivityLevel];
}

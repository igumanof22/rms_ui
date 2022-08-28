import 'package:equatable/equatable.dart';

abstract class ActivityLevelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityLevelFetch extends ActivityLevelEvent {
  ActivityLevelFetch();
}

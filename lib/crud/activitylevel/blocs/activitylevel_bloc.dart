import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/widgets.dart';

class ActivityLevelBloc extends Bloc<ActivityLevelEvent, ActivityLevelState> {
  ActivityLevelBloc() : super(ActivityLevelUninitialized()) {
    on(_onFetch);
  }

  Future<void> _onFetch(
      ActivityLevelFetch event, Emitter<ActivityLevelState> emit) async {
    try {
      emit(ActivityLevelLoading());

      List<ActivityLevel> listActivityLevel =
          await ActivityLevelService.fetch();

      emit(ActivityLevelInitialized(listActivityLevel: listActivityLevel));
    } catch (e) {
      log(e.toString(), name: 'ActivityLevelBloc - _onFetch');

      showSnackbar('Gagal ambil ActivityLevel', isError: true);

      emit(ActivityLevelError());
      rethrow;
    }
  }
}

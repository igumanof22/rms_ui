import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersUninitialized()) {
    on(_onCreate);
    on(_onFetch);
  }

  Future<void> _onFetch(UsersFetch event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      List<Users> listUsers = await UsersService.fetch();

      emit(UsersInitialized(listUsers: listUsers));
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onFetch');

      showSnackbar('Gagal ambil Users', isError: true);

      emit(UsersError());
    }
  }

  Future<void> _onCreate(UsersCreate event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      await UsersService.create(event.users);

      showSnackbar('Sukses tambah Users');

      emit(UsersCreateSuccess());

      add(UsersFetch());
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onCreate');

      showSnackbar('Gagal tambah Users', isError: true);

      emit(UsersError());
    }
  }
}

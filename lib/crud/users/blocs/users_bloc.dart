import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final SharedPreferences pref = App.instance.pref;

  UsersBloc() : super(UsersUninitialized()) {
    on(_onCreate);
    on(_onProfile);
    on(_onFetch);
    on(_onLogin);
    on(_onSignUp);
    on(_onGetData);
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

  Future<void> _onGetData(UsersGet event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      Users users = await UsersService.get(event.id);

      emit(UsersGetData(users: users));
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

      emit(UsersSuccess());

      add(UsersFetch());
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onCreate');

      showSnackbar('Gagal tambah Users', isError: true);

      emit(UsersError());
    }
  }

  Future<void> _onProfile(UsersProfile event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      await UsersService.profile(event.id, event.profileModel);

      showSnackbar('Sukses Ubah Profil User');

      emit(UsersSuccess());
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onProfile');

      showSnackbar('Gagal Ubah Profil User', isError: true);

      emit(UsersError());
      rethrow;
    }
  }

  Future<void> _onSignUp(UsersSignUp event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      await UsersService.signUp(event.signUpModel);

      showSnackbar('Sukses buat Users');

      emit(UsersSuccess());
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onSingUp');

      showSnackbar('Gagal buat Users', isError: true);

      emit(UsersError());
    }
  }

  Future<void> _onLogin(UsersLogin event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      UsersLoginModel login =
          await UsersService.login(event.username, event.password);

      await pref.clear();

      await pref.setString('email', login.email);
      await pref.setString('name', login.name);
      await pref.setString('role', login.role);
      await pref.setString('id', login.id);
      await pref.setString('logo', login.logo ?? "");

      await App.instance.init(pref);

      showSnackbar('Login Berhasil');

      emit(UsersSuccess());
    } catch (e) {
      log(e.toString(), name: 'UsersBloc - _onLogin');

      showSnackbar('Gagal Login', isError: true);

      emit(UsersError());
      rethrow;
    }
  }
}

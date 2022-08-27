import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static App? _instance;

  App._();

  static App get instance => _instance ??= App._();

  late Dio dio;
  late SharedPreferences pref;

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();

    String? role = pref.getString('role');
    String? name = pref.getString('name');
    String? email = pref.getString('email');

    BaseOptions options = BaseOptions(
      baseUrl: 'https://ikhsan.merapi.javan.id',
      headers: {
        'Name' : name,
        'Role' : role,
        'Email' : email
      }
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        log(e.requestOptions.uri.toString(), name: 'Dio Error');
        log(e.response!.data.toString());

        return handler.next(e);
      },
    ));

  }
}

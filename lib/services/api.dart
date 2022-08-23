import 'dart:developer';

import 'package:dio/dio.dart';

class API {
  static API? _instance;

  API._();

  static API get instance => _instance ??= API._();

  late Dio dio;

  void init() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://192.168.0.108:8000',
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        log(e.requestOptions.uri.toString(), name: 'Dio Error');

        return handler.next(e);
      },
    ));
  }
}

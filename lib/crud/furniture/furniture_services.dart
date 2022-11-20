import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class FurnitureService {
  static final Dio _dio = App.instance.dio;

  static Future<List<Furniture>> fetch(String name) async {
    Response response;

    if (name.isEmpty) {
      response = await _dio.get('/crud/furniture');
    } else {
      response = await _dio.get('/crud/furniture?name=$name');
    }

    return (response.data['data']['content'] as List)
        .map((elm) => Furniture.fromMap(elm))
        .toList();
  }

  static Future<void> create(Furniture furniture) async {
    await _dio.post('/crud/furniture', data: {
      'name': furniture.nama,
    });
  }

  static Future<Furniture> get(String id) async {
    Response respone = await _dio.get('/crud/furniture/$id');
    return Furniture.fromMap(respone.data['data']);
  }

  static Future<void> update(String id, Furniture furniture) async {
    await _dio.post('/crud/furniture/$id', data: {
      'name': furniture.nama,
    });
  }

  static Future<void> delete(String id) async {
    await _dio.delete('/crud/furniture/$id');
  }
}

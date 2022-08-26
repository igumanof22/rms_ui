import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class FurnitureService {
  static final Dio _dio = App.instance.dio;

  static Future<List<Furniture>> fetch() async {
    Response response = await _dio.get('/crud/furniture');

    return (response.data['data'] as List)
        .map((elm) => Furniture.fromMap(elm))
        .toList();
  }

  static Future<void> create(Furniture furniture) async {
    await _dio.post('/crud/furniture', data: {
      'nama': furniture.nama,
    });
  }

  static Future<Furniture> get(String id) async {
    Response respone = await _dio.get('/crud/furniture/$id');
    return Furniture.fromMap(respone);
  }

  static Future<void> update(String id, Furniture furniture) async {
    await _dio.post('/crud/furniture/$id', data: {
      'nama': furniture.nama,
    });
  }

  static Future<void> delete(String id) async {
    await _dio.delete('/crud/furniture/$id');
  }
}

import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class EquipmentService {
  static final Dio _dio = App.instance.dio;

  static Future<List<Equipment>> fetch() async {
    Response response = await _dio.get('/crud/equipment');

    return (response.data['data'] as List)
        .map((elm) => Equipment.fromMap(elm))
        .toList();
  }

  static Future<void> create(Equipment equipment) async {
    await _dio.post('/crud/equipment', data: {
      'nama': equipment.nama,
    });
  }

  static Future<Equipment> get(String id) async {
    Response respone = await _dio.get('/crud/equipment/$id');
    return Equipment.fromMap(respone);
  }

  static Future<void> update(String id, Equipment equipment) async {
    await _dio.post('/crud/equipment/$id', data: {
      'nama': equipment.nama,
    });
  }

  static Future<void> delete(String id) async {
    await _dio.get('/crud/equipment/$id');
  }
}

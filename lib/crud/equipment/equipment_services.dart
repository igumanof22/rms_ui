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
}

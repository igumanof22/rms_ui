import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/api.dart';

class EquipmentService {
  static final Dio _dio = API.instance.dio;

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

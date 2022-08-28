import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class ActivityLevelService {
  static final Dio _dio = App.instance.dio;

  static Future<List<ActivityLevel>> fetch() async {
    Response response = await _dio.get('/crud/activitylevel');

    return (response.data['data']['content'] as List)
        .map((elm) => ActivityLevel.fromMap(elm))
        .toList();
  }
}

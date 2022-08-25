import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response = await _dio.get('/bpmn/requestRoom');

    return (response.data['data'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<void> create(RequestRoom requestRoom) async {
    await _dio.post('/bpmn/requestRoom', data: {
      'startDate': requestRoom.startDate,
      'endDate': requestRoom.endDate,
      'startTime': requestRoom.startTime,
      'endTime': requestRoom.endTime,
      'activityName': requestRoom.activityName,
      'activityLevel': requestRoom.activityLevel,
    });
  }
}

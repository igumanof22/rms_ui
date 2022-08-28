import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response = await _dio.get('/bpmn/RequestRoom');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<void> create(RequestRoom requestRoom) async {
    await _dio
        .post('/bpmn/RequestRoom?withVariable=true&decision=submit', data: {
      'startDate': requestRoom.startDate,
      'endDate': requestRoom.endDate,
      'startTime': requestRoom.startTime,
      'endTime': requestRoom.endTime,
      'activityName': requestRoom.activityName,
      'activityLevel': requestRoom.activityLevel.toMap(),
      'participant': requestRoom.participant,
      'user': requestRoom.user.toMap(),
      'room': requestRoom.room.toMapRequest(),
    });
  }

  static Future<void> draft(RequestRoomDrafts requestRoom) async {
    await _dio
        .post('/bpmn/RequestRoom?withVariable=true&decision=draft', data: {
      'startDate': requestRoom.startDate,
      'endDate': requestRoom.endDate,
      'startTime': requestRoom.startTime,
      'endTime': requestRoom.endTime,
      'activityName': requestRoom.activityName,
      'activityLevel': requestRoom.activityLevel?.toMap(),
      'participant': requestRoom.participant,
      'user': requestRoom.user?.toMap(),
      'room': requestRoom.room?.toMapRequest(),
    });
  }
}

import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomModifyService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response = await _dio.get('/bpmn/RequestRoom/modifyRequest');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<void> submit(
      RequestRoom requestRoom, String fileName, String filePath) async {
    var pict = await MultipartFile.fromFile(filePath, filename: fileName);
    await _dio.post(
        '/bpmn/RequestRoom/modifyRequest?withVariable=true&pict=$pict',
        data: {
          'startDate': requestRoom.startDate,
          'endDate': requestRoom.endDate,
          'startTime': requestRoom.startTime,
          'endTime': requestRoom.endTime,
          'activityName': requestRoom.activityName,
          'activityLevel': requestRoom.activityLevel,
        });
  }
}

import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomCompleteService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response =
        await _dio.get('/bpmn/RequestRoom/completeRequest/list');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<DetailRequestRoom> getData(String id) async {
    Response response = await _dio.get('/bpmn/RequestRoom/completeRequest/$id');

    return DetailRequestRoom.fromMap(response.data['data']);
  }

  static Future<void> submit(
      String id, String fileName, String filePath) async {
    var pict = await MultipartFile.fromFile(filePath, filename: fileName);
    await _dio.post(
        '/bpmn/RequestRoom/reviewRequest/$id/submit?withVariable=true&pict=$pict',
        data: '{}');
  }
}

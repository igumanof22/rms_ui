import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomReviewL1Service {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response =
        await _dio.get('/bpmn/RequestRoom/reviewRequestL1/list');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<void> submit(String id, bool decision, String? reason) async {
    String path =
        '/bpmn/RequestRoom/reviewRequestL1/$id/submit?decision=$decision';
    if (decision == true) {
      await _dio.post(path, data: '');
    } else {
      await _dio.post('$path&withVariable=true&reason=$reason', data: '');
    }
  }
}

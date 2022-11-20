import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomReviewService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch(String requestId) async {
    Response response;

    if (requestId.isEmpty) {
      response = await _dio.get('/bpmn/RequestRoom/reviewRequest/list');
    } else {
      response = await _dio
          .get('/bpmn/RequestRoom/reviewRequest/list?requestId=$requestId');
    }

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<DetailRequestRoom> getData(String id) async {
    Response response = await _dio.get('/bpmn/RequestRoom/reviewRequest/$id');

    return DetailRequestRoom.fromMap(response.data['data']);
  }

  static Future<void> submit(String id, bool decision, String? reason) async {
    await _dio.post(
        '/bpmn/RequestRoom/reviewRequest/$id/submit?decision=$decision&withVariable=true&reason=$reason',
        data: '{}');
  }
}

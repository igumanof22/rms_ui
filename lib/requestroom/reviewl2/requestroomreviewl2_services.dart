import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RequestRoomReviewL2Service {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response =
        await _dio.get('/bpmn/RequestRoom/reviewRequestL2/list');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<DetailRequestRoom> getData(String id) async {
    Response response = await _dio.get('/bpmn/RequestRoom/reviewRequestL2/$id');

    return DetailRequestRoom.fromMap(response.data['data']);
  }

  static Future<void> submit(String id, bool decision, String? reason) async {
    await _dio.post(
        '/bpmn/RequestRoom/reviewRequestL2/$id/submit?decision=$decision&withVariable=true&reason=$reason',
        data: '{}');
  }
}

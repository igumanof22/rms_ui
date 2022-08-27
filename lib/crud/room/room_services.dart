import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class RoomService {
  static final Dio _dio = App.instance.dio;

  static Future<List<Room>> fetch() async {
    Response response = await _dio.get('/crud/room');

    return (response.data['data']['content'] as List)
        .map((elm) => Room.fromMap(elm))
        .toList();
  }

  static Future<Room> get(String id) async {
    Response respone = await _dio.get('/crud/room/$id');
    return Room.fromMap(respone.data['data']);
  }

  static Future<void> create(Room room) async {
    await _dio.post('/crud/room', data: room.toMap());
  }
}

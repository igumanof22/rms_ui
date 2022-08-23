import 'package:dio/dio.dart';
import 'package:rms_ui/common/models.dart';
import 'package:rms_ui/services/api.dart';

class RoomService {
  static final Dio _dio = API.instance.dio;

  static Future<List<Room>> fetch() async {
    Response response = await _dio.get('/crud/room');

    return (response.data['data'] as List)
        .map((elm) => Room.fromMap(elm))
        .toList();
  }

  static Future<void> create(Room room) async {
    await _dio.post('/crud/room', data: {
      'nama': room.nama,
      'roomId': room.roomId,
      'building': room.building,
      'category': room.category,
      'totalCapacity': room.totalCapacity,
    });
  }
}

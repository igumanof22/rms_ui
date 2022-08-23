import 'package:dio/dio.dart';
import 'package:rms_ui/common/models.dart';
import 'package:rms_ui/services/api.dart';

class UsersService {
  static final Dio _dio = API.instance.dio;

  static Future<List<Users>> fetch() async {
    Response response = await _dio.get('/crud/users');

    return (response.data['data'] as List)
        .map((elm) => Users.fromMap(elm))
        .toList();
  }

  static Future<void> create(Users users) async {
    await _dio.post('/crud/users', data: {
      'username': users.username,
      'password': users.password,
      'email': users.email,
      'name': users.name,
    });
  }
}

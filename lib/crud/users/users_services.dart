import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersService {
  static final SharedPreferences pref = App.instance.pref;
  static final Dio _dio = App.instance.dio;

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

  static Future<UsersLoginModel> login(String username, String password) async {
    Response response = await _dio.post('/crud/users/login', data: {
      'username': username,
      'password': password,
    });

    return UsersLoginModel.fromMap(response.data['data']);
  }
}

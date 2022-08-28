import 'package:dio/dio.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';

class UsersService {
  static final Dio _dio = App.instance.dio;

  static Future<List<Users>> fetch() async {
    Response response = await _dio.get('/crud/user');

    return (response.data['data']['content'] as List)
        .map((elm) => Users.fromMap(elm))
        .toList();
  }

  static Future<void> create(Users users) async {
    await _dio.post('/crud/user', data: {
      'username': users.username,
      'password': users.password,
      'email': users.email,
      'name': users.name,
      'role': users.role,
    });
  }

  static Future<Users> get(String id) async {
    Response respone = await _dio.get('/crud/user/$id');
    return Users.fromMap(respone.data['data']);
  }

  static Future<void> profile(String id, UsersProfileModel profile) async {
    var formData = FormData.fromMap({
      'leader': profile.leader,
      if (profile.leaderSignatureName != null &&
          profile.leaderSignatureName!.isNotEmpty)
        'leaderSignature': await MultipartFile.fromFile(
            profile.leaderSignaturePath!,
            filename: profile.leaderSignatureName),
      if (profile.logoName != null && profile.logoName!.isNotEmpty)
        'logo': await MultipartFile.fromFile(profile.logoPath!,
            filename: profile.logoName),
      if (profile.secretarySignatureName != null &&
          profile.secretarySignatureName!.isNotEmpty)
        'secretarySignature': await MultipartFile.fromFile(
            profile.secretarySignaturePath!,
            filename: profile.secretarySignatureName),
      'secretary': profile.secretary,
    });
    await _dio.post('/crud/user/profile/$id', data: formData);
  }

  static Future<void> signUp(UsersSignUpModel signUpModel) async {
    await _dio.post('/common/signup', data: {
      'username': signUpModel.username,
      'password': signUpModel.password,
      'email': signUpModel.email,
      'name': signUpModel.name,
    });
  }

  static Future<UsersLoginModel> login(String username, String password) async {
    Response response = await _dio.post('/common/login', data: {
      'username': username,
      'password': password,
    });

    return UsersLoginModel.fromMap(response.data['data']);
  }
}

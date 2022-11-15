import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';
import 'package:rms_ui/widgets/snackbar.dart';

class RequestRoomService {
  static final Dio _dio = App.instance.dio;

  static Future<List<RequestRoom>> fetch() async {
    Response response = await _dio.get('/bpmn/RequestRoom');

    return (response.data['data']['content'] as List)
        .map((elm) => RequestRoom.fromMap(elm))
        .toList();
  }

  static Future<DetailRequestRoom> getData(String id) async {
    Response response = await _dio.get('/bpmn/RequestRoom/$id');

    return DetailRequestRoom.fromMap(response.data['data']);
  }

  static Future<void> create(
      RequestRoom requestRoom, String fileName, String filePath) async {
    var formData = FormData.fromMap(
        {'pict': await MultipartFile.fromFile(filePath, filename: fileName)});
    Response response =
        await _dio.post('/bpmn/RequestRoom/upload', data: formData);

    Minio minio = Minio.fromMap(response.data['data']);

    var outputFormat = DateFormat('yyyy-MM-dd');
    await _dio
        .post('/bpmn/RequestRoom?withVariable=true&decision=submit', data: {
      'startDate': outputFormat.format(requestRoom.startDate),
      'endDate': outputFormat.format(requestRoom.endDate),
      'startTime': requestRoom.startTime,
      'endTime': requestRoom.endTime,
      'activityName': requestRoom.activityName,
      'activityLevel': requestRoom.activityLevel.toMap(),
      'participant': requestRoom.participant,
      'user': requestRoom.user.toMap(),
      'room': requestRoom.room.toMapRequest(),
      'firstPictPath': minio.filePath,
    });
  }

  static Future<void> draft(
      RequestRoomDrafts requestRoom, String fileName, String filePath) async {
    var formData = FormData.fromMap(
        {'pict': await MultipartFile.fromFile(filePath, filename: fileName)});
    Response response =
        await _dio.post('/bpmn/RequestRoom/upload', data: formData);

    Minio minio = Minio.fromMap(response.data['data']);

    await _dio
        .post('/bpmn/RequestRoom?withVariable=true&decision=draft', data: {
      'startDate': requestRoom.startDate,
      'endDate': requestRoom.endDate,
      'startTime': requestRoom.startTime,
      'endTime': requestRoom.endTime,
      'activityName': requestRoom.activityName,
      'activityLevel': requestRoom.activityLevel?.toMap(),
      'participant': requestRoom.participant,
      'user': requestRoom.user?.toMap(),
      'room': requestRoom.room?.toMapRequest(),
      'firstPictPath': minio.filePath,
    });
  }

  static Future<void> download(String id) async {
    Directory? directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      directory = await getExternalStorageDirectory();
    }

    String fileUrl = '/bpmn/RequestRoom/$id/generate';

    if (directory != null) {
      String savename = "Surat Peminjaman Gedung.pdf";
      String savePath = "${directory.path}/$savename";
      await Dio().download(fileUrl, savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          showSnackbar("${(received / total * 100).toStringAsFixed(0)}%");
        }
      });
    }
  }
}

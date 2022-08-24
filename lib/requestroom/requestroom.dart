import 'package:rms_ui/barrel/models.dart';

class RequestRoom {
  final String? id;
  final String? requestId;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final String activityName;
  final String activityLevel;
  final Room? room;

  RequestRoom({
    this.id,
    this.requestId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.activityName,
    required this.activityLevel,
    this.room,
  });

  factory RequestRoom.fromMap(dynamic map) {
    return RequestRoom(
      id: map['id'],
      requestId: map['requestId'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      activityName: map['endTime'],
      activityLevel: map['endTime'],
      room: map['room'],
    );
  }
}

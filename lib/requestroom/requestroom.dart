import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/models.dart';

class RequestRoom {
  final String? id;
  final String? requestId;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final String activityName;
  final ActivityLevel activityLevel;
  final int participant;
  final Room room;
  final Users user;
  final String? status;

  RequestRoom({
    this.id,
    this.requestId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.activityName,
    required this.activityLevel,
    required this.participant,
    required this.room,
    required this.user,
    this.status,
  });

  factory RequestRoom.fromMap(dynamic map) {
    var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'+'HH:mm");
    return RequestRoom(
      id: map['id'],
      requestId: map['requestId'],
      startDate: outputFormat.parse(map['startDate']),
      endDate: outputFormat.parse(map['endDate']),
      startTime: map['startTime'],
      endTime: map['endTime'],
      activityName: map['activityName'],
      activityLevel: ActivityLevel.fromMap(map['activityLevel']),
      participant: map['participant'],
      room: Room.fromMap(map['room']),
      user: Users.fromMap(map['user']),
      status: map['status'],
    );
  }
}

class DetailRequestRoom {
  final RequestRoom requestRoom;
  final List<Log> logs;

  DetailRequestRoom({
    required this.requestRoom,
    required this.logs,
  });

  factory DetailRequestRoom.fromMap(dynamic map) {
    return DetailRequestRoom(
      requestRoom: RequestRoom.fromMap(map['object']),
      logs: (map['logs'] as List).map((e) => Log.fromMap(e)).toList()
    );
  }
}

class Log {
  final DateTime createdDate;
  final String actBy;
  final String actByName;
  final String? remarks;
  final String decisionRemark;

  Log({
    required this.createdDate,
    required this.actBy,
    required this.actByName,
    this.remarks,
    required this.decisionRemark,
  });

  factory Log.fromMap(dynamic map) {
    var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'+'HH:mm");

    return Log(
      createdDate: outputFormat.parse(map['createdDate']),
      actBy: map['actBy'],
      actByName: map['actByName'],
      remarks: map['remarks'],
      decisionRemark: map['decisionRemark'],
    );
  }
}

class RequestRoomDrafts {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? startTime;
  final String? endTime;
  final String? activityName;
  final ActivityLevel? activityLevel;
  final int? participant;
  final Room? room;
  final Users? user;

  RequestRoomDrafts({
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.activityName,
    this.activityLevel,
    this.participant,
    this.room,
    this.user,
  });
}

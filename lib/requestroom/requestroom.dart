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
  final String? submittedBy;
  final DateTime? submittedDate;
  final String? reviewedBy;
  final DateTime? reviewedDate;
  final String? approvedBy;
  final DateTime? approvedDate;

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
    this.submittedBy,
    this.submittedDate,
    this.reviewedBy,
    this.reviewedDate,
    this.approvedBy,
    this.approvedDate,
  });

  factory RequestRoom.fromMap(dynamic map) {
    return RequestRoom(
      id: map['id'],
      requestId: map['requestId'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      activityName: map['activityName'],
      activityLevel: ActivityLevel.fromMap(map['activityLevel']),
      participant: map['participant'],
      room: Room.fromMap(map['room']),
      user: Users.fromMap(map['user']),
      status: map['status'],
      submittedBy: map['submittedBy'],
      submittedDate: map['submittedDate'],
      reviewedBy: map['reviewedBy'],
      reviewedDate: map['reviewedDate'],
      approvedBy: map['approvedBy'],
      approvedDate: map['approvedDate'],
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

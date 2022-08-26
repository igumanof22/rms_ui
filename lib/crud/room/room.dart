import '../../barrel/models.dart';

class Room {
  final String? id;
  final String nama;
  final String roomId;
  final String building;
  final String category;
  final int totalCapacity;
  final List<RoomItem> roomItem;

  Room({
    this.id,
    required this.nama,
    required this.roomId,
    required this.building,
    required this.category,
    required this.totalCapacity,
    required this.roomItem,
  });

  factory Room.fromMap(dynamic map) {
    return Room(
      id: map['id'],
      nama: map['nama'],
      roomId: map['roomId'],
      building: map['building'],
      category: map['category'],
      totalCapacity: map['totalCapacity'],
      roomItem:
          (map['roomItem'] as List).map((e) => RoomItem.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'roomId': roomId,
      'building': building,
      'category': category,
      'totalCapacity': totalCapacity,
      'roomItem': roomItem.map((e) => e.toMap()),
    };
  }
}

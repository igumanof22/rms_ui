import 'package:rms_ui/barrel/models.dart';

class RoomItem {
  final String? id;
  final Equipment? equipment;
  final Furniture? furniture;
  final int total;
  final String condition;

  RoomItem({
    this.id,
    this.equipment,
    this.furniture,
    required this.total,
    required this.condition,
  });

  factory RoomItem.fromMap(dynamic map) {
    return RoomItem(
      id: map['id'],
      equipment: map['equipment'] != null ? Equipment.fromMap(map['equipment']) : null,
      furniture: map['furniture'] != null ? Furniture.fromMap(map['furniture']) : null,
      total: map['total'],
      condition: map['condition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'equipment': equipment?.toMap(),
      'furniture': furniture?.toMap(),
      'total': total,
      'condition': condition,
    };
  }
}

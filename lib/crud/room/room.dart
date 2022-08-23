class Room {
  final String? id;
  final String nama;
  final String roomId;
  final String building;
  final String category;
  final int totalCapacity;

  Room({
    this.id,
    required this.nama,
    required this.roomId,
    required this.building,
    required this.category,
    required this.totalCapacity,
  });

  factory Room.fromMap(dynamic map) {
    return Room(
      id: map['id'],
      nama: map['nama'],
      roomId: map['roomId'],
      building: map['building'],
      category: map['category'],
      totalCapacity: map['totalCapacity'],
    );
  }
}

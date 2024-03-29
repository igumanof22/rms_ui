class Equipment {
  final String? id;
  final String nama;

  Equipment({
    this.id,
    required this.nama,
  });

  factory Equipment.fromMap(dynamic map) {
    return Equipment(
      id: map['id'],
      nama: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}

class ActivityLevel {
  final String? id;
  final String nama;

  ActivityLevel({
    this.id,
    required this.nama,
  });

  factory ActivityLevel.fromMap(dynamic map) {
    return ActivityLevel(
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

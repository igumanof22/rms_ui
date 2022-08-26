class Furniture {
  final String? id;
  final String nama;

  Furniture({
    this.id,
    required this.nama,
  });

  factory Furniture.fromMap(dynamic map) {
    return Furniture(
      id: map['id'],
      nama: map['nama'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}

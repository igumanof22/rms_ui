class Users {
  final String? id;
  final String username;
  final String password;
  final String email;
  final String name;
  final String? role;
  final String? logoPath;
  final String? leader;
  final String? leaderSignature;
  final String? secretary;
  final String? secretarySignature;

  Users({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    this.role,
    this.logoPath,
    this.leader,
    this.leaderSignature,
    this.secretary,
    this.secretarySignature,
  });

  factory Users.fromMap(dynamic map) {
    return Users(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
      logoPath: map['logoPath'],
      leader: map['leader'],
      leaderSignature: map['leaderSignature'],
      secretary: map['secretary'],
      secretarySignature: map['secretarySignature'],
    );
  }
}

class UsersLoginModel {
  final String email;
  final String name;
  final String role;

  UsersLoginModel({
    required this.email,
    required this.name,
    required this.role,
  });

  factory UsersLoginModel.fromMap(dynamic map) {
    return UsersLoginModel(
      email: map['email'],
      name: map['name'],
      role: map['role'],
    );
  }
}

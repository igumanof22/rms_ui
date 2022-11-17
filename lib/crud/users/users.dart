class Users {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? name;
  final String? role;
  final String? logoPath;
  final String? leader;
  final String? leaderSignature;
  final String? secretary;
  final String? secretarySignature;

  Users({
    this.id,
    this.username,
    this.password,
    this.email,
    this.name,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}

class UsersLoginModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? logo;

  UsersLoginModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.logo,
  });

  factory UsersLoginModel.fromMap(dynamic map) {
    return UsersLoginModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
      logo: map['logo'],
    );
  }
}

class UsersSignUpModel {
  final String username;
  final String password;
  final String email;
  final String name;

  UsersSignUpModel({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });
}

class UsersProfileModel {
  final String? logoPath;
  final String? logoName;
  final String? leaderSignaturePath;
  final String? leaderSignatureName;
  final String? secretarySignaturePath;
  final String? secretarySignatureName;
  final String? elderSignaturePath;
  final String? elderSignatureName;
  final String? leader;
  final String? nimNipLeader;
  final String? secretary;
  final String? nimNipSecretary;
  final String? elder;
  final String? nipElder;

  UsersProfileModel({
    this.logoPath,
    this.logoName,
    this.leaderSignaturePath,
    this.leaderSignatureName,
    this.secretarySignaturePath,
    this.secretarySignatureName,
    this.elderSignaturePath,
    this.elderSignatureName,
    this.leader,
    this.nimNipLeader,
    this.secretary,
    this.nimNipSecretary,
    this.elder,
    this.nipElder
  });
}

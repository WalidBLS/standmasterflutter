import 'dart:convert';

class InteractionUser {
  final int id;
  final String name;
  final String email;
  final String role;

  InteractionUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory InteractionUser.fromMap(Map<String, dynamic> json) {
    return InteractionUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory InteractionUser.fromJson(String source) {
    return InteractionUser.fromMap(json.decode(source));
  }
}

class InteractionStand {
  final int id;
  final String name;
  final String description;
  final String type;
  final int price;

  InteractionStand({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
  });

  factory InteractionStand.fromMap(Map<String, dynamic> json) {
    return InteractionStand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
    );
  }

  factory InteractionStand.fromJson(String source) {
    return InteractionStand.fromMap(json.decode(source));
  }
}

class InteractionKermesse {
  final int id;
  final String name;
  final String description;
  final String status;

  InteractionKermesse({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory InteractionKermesse.fromMap(Map<String, dynamic> json) {
    return InteractionKermesse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  factory InteractionKermesse.fromJson(String source) {
    return InteractionKermesse.fromMap(json.decode(source));
  }
}

class InteractionDetailsResponse {
  final int id;
  final String type;
  final String status;
  final int credit;
  final int point;
  final InteractionUser user;
  final InteractionStand stand;
  final InteractionKermesse kermesse;

  InteractionDetailsResponse({
    required this.id,
    required this.type,
    required this.status,
    required this.credit,
    required this.point,
    required this.user,
    required this.stand,
    required this.kermesse,
  });

  factory InteractionDetailsResponse.fromMap(Map<String, dynamic> json) {
    return InteractionDetailsResponse(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      credit: json['credit'],
      point: json['point'],
      user: InteractionUser.fromMap(json['user']),
      stand: InteractionStand.fromMap(json['stand']),
      kermesse: InteractionKermesse.fromMap(json['kermesse']),
    );
  }

  factory InteractionDetailsResponse.fromJson(String source) {
    return InteractionDetailsResponse.fromMap(json.decode(source));
  }
}

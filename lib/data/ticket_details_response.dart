import 'dart:convert';

class TicketUser {
  final int id;
  final String name;
  final String email;
  final String role;

  TicketUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory TicketUser.fromMap(Map<String, dynamic> json) {
    return TicketUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory TicketUser.fromJson(String source) {
    return TicketUser.fromMap(json.decode(source));
  }
}

class TicketTombola {
  final int id;
  final String name;
  final String status;
  final int price;
  final String gift;

  TicketTombola({
    required this.id,
    required this.name,
    required this.status,
    required this.price,
    required this.gift,
  });

  factory TicketTombola.fromMap(Map<String, dynamic> json) {
    return TicketTombola(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      price: json['price'],
      gift: json['gift'],
    );
  }

  factory TicketTombola.fromJson(String source) {
    return TicketTombola.fromMap(json.decode(source));
  }
}

class TicketKermesse {
  final int id;
  final String name;
  final String description;
  final String status;

  TicketKermesse({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory TicketKermesse.fromMap(Map<String, dynamic> json) {
    return TicketKermesse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  factory TicketKermesse.fromJson(String source) {
    return TicketKermesse.fromMap(json.decode(source));
  }
}

class TicketDetailsResponse {
  final int id;
  final bool isWinner;
  final TicketUser user;
  final TicketTombola tombola;
  final TicketKermesse kermesse;

  TicketDetailsResponse({
    required this.id,
    required this.isWinner,
    required this.user,
    required this.tombola,
    required this.kermesse,
  });

  factory TicketDetailsResponse.fromMap(Map<String, dynamic> json) {
    return TicketDetailsResponse(
      id: json['id'],
      isWinner: json['is_winner'],
      user: TicketUser.fromMap(json['user']),
      tombola: TicketTombola.fromMap(json['tombola']),
      kermesse: TicketKermesse.fromMap(json['kermesse']),
    );
  }

  factory TicketDetailsResponse.fromJson(String source) {
    return TicketDetailsResponse.fromMap(json.decode(source));
  }
}

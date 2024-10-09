import 'dart:convert';

class GetMeResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final bool hasStand;

  GetMeResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.hasStand,
  });

  factory GetMeResponse.fromMap(Map<String, dynamic> json) {
    return GetMeResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      hasStand: json['has_stand'],
    );
  }

  factory GetMeResponse.fromJson(String source) {
    return GetMeResponse.fromMap(json.decode(source));
  }
}

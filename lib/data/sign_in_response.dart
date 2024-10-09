import 'dart:convert';

class SignInResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final String token;
  final bool hasStand;

  SignInResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
    required this.hasStand,
  });

  factory SignInResponse.fromMap(Map<String, dynamic> json) {
    return SignInResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
      hasStand: json['has_stand'],
    );
  }

  factory SignInResponse.fromJson(String source) {
    return SignInResponse.fromMap(json.decode(source));
  }
}

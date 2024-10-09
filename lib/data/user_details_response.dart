import 'dart:convert';

class UserDetailsResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final int credit;

  UserDetailsResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.credit,
  });

  factory UserDetailsResponse.fromMap(Map<String, dynamic> json) {
    return UserDetailsResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      credit: json['credit'],
    );
  }

  factory UserDetailsResponse.fromJson(String source) {
    return UserDetailsResponse.fromMap(json.decode(source));
  }
}

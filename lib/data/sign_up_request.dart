import 'dart:convert';

class SignUpRequest {
  final String name;
  final String email;
  final String password;
  final String role;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });
  }
}

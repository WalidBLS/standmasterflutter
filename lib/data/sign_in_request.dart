import 'dart:convert';

class SignInRequest {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  String toJson() {
    return json.encode({
      'email': email,
      'password': password,
    });
  }
}

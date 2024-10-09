import 'dart:convert';

class UserEditRequest {
  final String password;
  final String newPassword;

  UserEditRequest({
    required this.password,
    required this.newPassword,
  });

  String toJson() {
    return json.encode({
      'password': password,
      'new_password': newPassword,
    });
  }
}

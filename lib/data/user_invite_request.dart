import 'dart:convert';

class UserInviteRequest {
  final String name;
  final String email;

  UserInviteRequest({
    required this.name,
    required this.email,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'email': email,
    });
  }
}

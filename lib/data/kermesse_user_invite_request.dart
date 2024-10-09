import 'dart:convert';

class KermesseUserInviteRequest {
  final int userId;

  KermesseUserInviteRequest({
    required this.userId,
  });

  String toJson() {
    return json.encode({
      'user_id': userId,
    });
  }
}

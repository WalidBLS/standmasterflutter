import 'dart:convert';

class UserCreditSendRequest {
  final int childId;
  final int amount;

  UserCreditSendRequest({
    required this.childId,
    required this.amount,
  });

  String toJson() {
    return json.encode({
      'child_id': childId,
      'amount': amount,
    });
  }
}

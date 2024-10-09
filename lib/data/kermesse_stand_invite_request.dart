import 'dart:convert';

class KermesseStandInviteRequest {
  final int standId;

  KermesseStandInviteRequest({
    required this.standId,
  });

  String toJson() {
    return json.encode({
      'stand_id': standId,
    });
  }
}

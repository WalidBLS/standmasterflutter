import 'dart:convert';

class TicketCreateRequest {
  final int tombolaId;

  TicketCreateRequest({
    required this.tombolaId,
  });

  String toJson() {
    return json.encode({
      'tombola_id': tombolaId,
    });
  }
}

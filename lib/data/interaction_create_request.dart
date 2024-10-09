import 'dart:convert';

class InteractionCreateRequest {
  final int kermesseId;
  final int standId;
  final int quantity;

  InteractionCreateRequest({
    required this.kermesseId,
    required this.standId,
    required this.quantity,
  });

  String toJson() {
    return json.encode({
      'kermesse_id': kermesseId,
      'stand_id': standId,
      'quantity': quantity,
    });
  }
}

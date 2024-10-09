import 'dart:convert';

class InteractionEndRequest {
  final int point;

  InteractionEndRequest({
    required this.point,
  });

  String toJson() {
    return json.encode({
      'point': point,
    });
  }
}

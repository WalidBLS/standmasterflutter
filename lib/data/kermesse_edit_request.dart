import 'dart:convert';

class KermesseEditRequest {
  final String name;
  final String description;

  KermesseEditRequest({
    required this.name,
    required this.description,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'description': description,
    });
  }
}

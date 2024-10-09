import 'dart:convert';

class KermesseCreateRequest {
  final String name;
  final String description;

  KermesseCreateRequest({
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

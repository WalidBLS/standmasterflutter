import 'dart:convert';

class StandCreateRequest {
  final String type;
  final String name;
  final String description;
  final int price;
  final int stock;

  StandCreateRequest({
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  String toJson() {
    return json.encode({
      'type': type,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
    });
  }
}

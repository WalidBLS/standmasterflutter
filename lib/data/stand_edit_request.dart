import 'dart:convert';

class StandEditRequest {
  final String name;
  final String description;
  final int price;
  final int stock;

  StandEditRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
    });
  }
}

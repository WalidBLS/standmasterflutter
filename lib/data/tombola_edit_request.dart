import 'dart:convert';

class TombolaEditRequest {
  final String name;
  final int price;
  final String gift;

  TombolaEditRequest({
    required this.name,
    required this.price,
    required this.gift,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'price': price,
      'gift': gift,
    });
  }
}

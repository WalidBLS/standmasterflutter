import 'dart:convert';

class StandDetailsResponse {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String type;
  final int price;
  final int stock;

  StandDetailsResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.stock,
  });

  factory StandDetailsResponse.fromMap(Map<String, dynamic> json) {
    return StandDetailsResponse(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
      stock: json['stock'],
    );
  }

  factory StandDetailsResponse.fromJson(String source) {
    return StandDetailsResponse.fromMap(json.decode(source));
  }
}

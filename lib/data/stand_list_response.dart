import 'dart:convert';

class StandListItem {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String type;
  final int price;
  final int stock;

  StandListItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.stock,
  });

  factory StandListItem.fromMap(Map<String, dynamic> json) {
    return StandListItem(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
      stock: json['stock'],
    );
  }

  factory StandListItem.fromJson(String source) {
    return StandListItem.fromMap(json.decode(source));
  }
}

class StandListResponse {
  final List<StandListItem> stands;

  StandListResponse({
    required this.stands,
  });

  factory StandListResponse.fromList(List<dynamic> list) {
    return StandListResponse(
      stands: list.map((item) => StandListItem.fromMap(item)).toList(),
    );
  }

  factory StandListResponse.fromJson(String source) {
    return StandListResponse.fromList(json.decode(source));
  }
}

import 'dart:convert';

class KermesseListItem {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String status;

  KermesseListItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.status,
  });

  factory KermesseListItem.fromMap(Map<String, dynamic> json) {
    return KermesseListItem(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  factory KermesseListItem.fromJson(String source) {
    return KermesseListItem.fromMap(json.decode(source));
  }
}

class KermesseListResponse {
  final List<KermesseListItem> kermesses;

  KermesseListResponse({
    required this.kermesses,
  });

  factory KermesseListResponse.fromList(List<dynamic> list) {
    return KermesseListResponse(
      kermesses: list.map((item) => KermesseListItem.fromMap(item)).toList(),
    );
  }

  factory KermesseListResponse.fromJson(String source) {
    return KermesseListResponse.fromList(json.decode(source));
  }
}

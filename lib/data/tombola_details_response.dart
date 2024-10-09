import 'dart:convert';

class TombolaDetailsResponse {
  final int id;
  final int kermesseId;
  final String name;
  final String status;
  final int price;
  final String gift;

  TombolaDetailsResponse({
    required this.id,
    required this.kermesseId,
    required this.name,
    required this.status,
    required this.price,
    required this.gift,
  });

  factory TombolaDetailsResponse.fromMap(Map<String, dynamic> json) {
    return TombolaDetailsResponse(
      id: json['id'],
      kermesseId: json['kermesse_id'],
      name: json['name'],
      status: json['status'],
      price: json['price'],
      gift: json['gift'],
    );
  }

  factory TombolaDetailsResponse.fromJson(String source) {
    return TombolaDetailsResponse.fromMap(json.decode(source));
  }
}

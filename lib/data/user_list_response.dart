import 'dart:convert';

class UserListItem {
  final int id;
  final String name;
  final String email;
  final String role;
  final int credit;

  UserListItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.credit,
  });

  factory UserListItem.fromMap(Map<String, dynamic> json) {
    return UserListItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      credit: json['credit'],
    );
  }

  factory UserListItem.fromJson(String source) {
    return UserListItem.fromMap(json.decode(source));
  }
}

class UserListResponse {
  final List<UserListItem> users;

  UserListResponse({
    required this.users,
  });

  factory UserListResponse.fromList(List<dynamic> list) {
    return UserListResponse(
      users: list.map((item) => UserListItem.fromMap(item)).toList(),
    );
  }

  factory UserListResponse.fromJson(String source) {
    return UserListResponse.fromList(json.decode(source));
  }
}

import 'package:flutter/material.dart';

import 'package:standmaster/providers/auth_user.dart';

class AuthProvider extends ChangeNotifier {
  AuthUser _user = AuthUser.getEmpty();

  AuthUser get user {
    return _user;
  }

  bool get isLogged {
    return _user.id >= 0;
  }

  void setUser(
    int id,
    String name,
    String email,
    String role,
    bool hasStand,
  ) {
    _user = AuthUser(
      id: id,
      name: name,
      email: email,
      role: role,
      hasStand: hasStand,
    );
    notifyListeners();
  }

  void setHasStand(
    bool hasStand,
  ) {
    _user = AuthUser(
      id: _user.id,
      name: _user.name,
      email: _user.email,
      role: _user.role,
      hasStand: hasStand,
    );
    notifyListeners();
  }
}

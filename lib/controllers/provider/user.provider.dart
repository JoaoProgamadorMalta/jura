import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  String? _role;
  String? _name;
  DateTime? _createdAt;

  String? get email => _email;
  String? get role => _role;
  String? get name => _name;
  DateTime? get createdAt => _createdAt;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setCreatedAt(DateTime? createdAt) {
    _createdAt = createdAt;
    notifyListeners();
  }

  void logout(){
    _email = null;
    _name = null;
    _role = null;
    _createdAt = null;
  }
}
import 'package:therapist_app/models/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    name: '',
    email: '',
    password: '',
    mobile: '',
    experience: '',
    about: '',
    clients: 0,
    status: '',
    // type: '',
    token: '',
  );

  User get user => _user;

  get http => null;

  void setUser(String userData) {
    _user = User.fromJson(userData);
    notifyListeners();
  }
}

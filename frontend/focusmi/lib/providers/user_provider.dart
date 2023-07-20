import 'package:flutter/material.dart';
import 'package:focusmi/models/user.dart';



class UserProvider extends ChangeNotifier{
  User _user = User(id:'',username:'',password: '',email:'',token: '');
  User get user => _user;
  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }
}
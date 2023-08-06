import 'package:flutter/material.dart';
import 'package:focusmi/models/user.dart';



class UserProvider extends ChangeNotifier{
  
  User _user = User(user_id:0,username:'',password: '',email:'',token: '');
  User get user => _user;
  void setUser(user){
    print(user);
    User newuser= User(user_id: user['user_id'], username: user['username'], email: user['email'], password: user['password'], token: user['token']);
    _user = newuser;
    notifyListeners();
  }
}
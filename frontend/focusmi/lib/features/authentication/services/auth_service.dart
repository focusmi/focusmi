import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/error_handling.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/constants/utils.dart';
import 'package:focusmi/features/mainpage/screens/main_page.dart';
import 'package:focusmi/models/user.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService{
  //signup 
  void signInUser({
    required BuildContext context,
    required String email,
    required String password
  }) async {
    try{
     
      User user = User(
        id: '',
        username: '',
        password: password,
        email: email,
        token: ''
      );
      
      http.Response res = await http.post(Uri.parse('$uri/api/signin'), body: user.toJson(), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(response: res, context: context, onSuccess: ()async{
        showSnackBar(context, "Successful");
        SharedPreferences prefs =await SharedPreferences.getInstance();
        await prefs.setString('auth-token', (jsonDecode(res.body))['acccesstoken']);
        print("++");
        print((jsonDecode(res.body))['acccesstoken']);
        Provider.of<UserProvider>(context, listen:false).setUser(res.body);
        print("---");
        print(prefs.getString('auth-token'));
      });
        // Navigator.pushNamed(context, MainScreen.routeName);
      
    }catch(e){
        //watch the video
    }
  }
  
  void createUser({
    required String email,
    required String username,
    required String password
    }) async {
      try{
        User user = User(email: email, username: username, password: password, id: '',token:' ');
        http.Response res = await http.post(Uri.parse('$uri/api/signup'), body: user.toJson(), headers:<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      }
      catch(e){

      }
  }
}
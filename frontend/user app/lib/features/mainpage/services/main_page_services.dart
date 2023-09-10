import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPageServices {
  static Future getBlogs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(Uri.parse('$uri/api/get-all-blogs'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  
}

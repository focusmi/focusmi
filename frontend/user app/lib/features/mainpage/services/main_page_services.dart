import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/notification.dart';
import 'package:focusmi/models/user.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageServices {
  static Future getCoursesByType() async {
    try {
      
    } catch (e) {
      print(e);
    }
  }

  static Future getBlogs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http
          .get(Uri.parse('$uri/api/get-all-blogs'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer ' + token.toString()
      });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getCoursesFeatured() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-all-featured-courses'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future createNotficationTask(context, taskid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = Provider.of<UserProvider>(context).user.user_id;
      var token = prefs.getString('auth-token');
      http.Response res = await http.post(
          Uri.parse('$uri/api/create-puser-notification'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          },
          body: Notifications(
              user_id: id,
              text: "",
              type: "task",
              status: "active",
              task_id: taskid));
    } catch (e) {}
  }

  static Future getNotfication(context) async {
    try {
      int id = Provider.of<UserProvider>(context).user.user_id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http
          .get(Uri.parse('$uri/api/get-noti'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer ' + token.toString()
      });
      return res;
    } catch (e) {}
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:focusmi/constants/global_variables.dart';

class GTaskPlannerServices {
  static Future createTaskPlan(TaskPlan taskplan) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res =
          await http.post(Uri.parse('$uri/api/create-task-plan'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ' + token.toString()
              },
              body: taskplan.toJson());
      return jsonDecode(res.body)['plan_id'];
    } catch (e) {
      print(e);
    }
  }

  static Future getTaskPlanByGroup(int groupid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-plan-by-group/$groupid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static void renameTaskPlan(TaskPlan taskPlan) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-recent-task-by-user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {
      print(e);
    }
  }

 static Future getRecentTaskPlan() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(Uri.parse('$uri/api/get-recent-task-by-user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static void dropTaskPlan() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(Uri.parse('$uri/api/delete-task-plan'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {
      print(e);
    }
  }

  static void addTask() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.post(
          Uri.parse('$uri/api/create-task-plan'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {}
  }
}

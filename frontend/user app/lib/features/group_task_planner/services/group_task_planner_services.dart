import 'package:flutter/foundation.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:focusmi/constants/global_variables.dart';

class GTaskPlannerServices {
  static void createTaskPlan(TaskPlan taskplan) async {
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
    } 
    catch (e) {
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
      List<TaskPlan> result= res.fromMap(Map<String, dynamic> map){

      };
      return res;
    } catch (e) {
      print(e);
    }
  }

  static void renameTaskPlan(TaskPlan taskPlan) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res =
          await http.post(Uri.parse('$uri/api/rename-task-planner'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ' + token.toString()
              },
              body: taskPlan.toJson());
    } catch (e) {
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
    } catch (e) {
    }
  }
}

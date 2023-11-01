import 'dart:convert';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:focusmi/constants/global_variables.dart';

class GTaskPlannerServices {
  static Future getUserById(int userid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-user-by-id/$userid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
     
      return res;
    } catch (e) {}
  }

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
    } catch (e) {}
  }

  static Future getChatByGroup(int groupid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-chat-by-group/$groupid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {}
  }

  static Future getITaskPlanByUser(int userid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-by-iplan-user/$userid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {}
  }

  static void renameTaskPlan(TaskPlan taskPlan) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res =
          await http.post(Uri.parse('$uri/api/rename-task-plan'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ' + token.toString()
              },
              body: taskPlan.toJson());
    } catch (e) {
      print(e);
    }
  }

  static void setTaskAttr(attr, task, val) async {
    print("-------------");
    print(attr);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/set-task-attr/${task}/${attr}/${val}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future getTaskAttr(attr, task) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-task-attr/${task}/${attr}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );

      return res;
    } catch (e) {
      print("error");
      print(e);
      print("error");
    }
  }

  static Future getTaskByPlan(taskplanid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-by-plan/${taskplanid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future editGroupMember(groupid, status, context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var userid =
          Provider.of<UserProvider>(context, listen: false).user.user_id;
      http.Response res = await http.get(
          Uri.parse('$uri/api/change-prevs/${userid}/${groupid}/${status}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future changeNoti(notid, status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/change-noti-status/${notid}/${status}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }
  // static Future createNotificatio()

  static Future getTaskByPlanFilterByUser(taskplanid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-by-plan-user/${taskplanid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getRecentTaskPlan() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-recent-task-by-user'),
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

  static void addTask(Task task) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.post(Uri.parse('$uri/api/create-task'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          },
          body: task.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future addTaskColor(task_id, color) async {
    try {
      Task taskplan = Task(
          task_id: task_id,
          plan_id: 0,
          timer_id: 0,
          task_name: '',
          task_type: '',
          duration: 0,
          task_status: '',
          priority: 0,
          created_at: '',
          color: color,
          description: '',
          is_text_field: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res =
          await http.post(Uri.parse('$uri/api/change-task-color'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ' + token.toString()
              },
              body: taskplan.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future getColor(taskid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-attr/${taskid}/color'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      print(res);
    } catch (e) {
      print(e);
    }
  }

  // subtask functions
  static Future createSubTask(SubTask stask) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.post(Uri.parse('$uri/api/create-subtask'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          },
          body: stask.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future getAllSubTask(taskid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-all-sub-task/${taskid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future updateSubTask(staskid, status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/update-sub-task/${staskid}/${status}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getSubTaskUser(subtaskid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-subtask-users/${subtaskid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      print(res.body);
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future setSubTaskUser(subtaskid, userid) async {
    print('$uri/api/allocate-subtask-users/${subtaskid}/${userid}');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/allocate-subtask-users/${subtaskid}/${userid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {
      print(e);
    }
  }

  static Future getTaskUser(taskid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-task-users/${taskid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      print(res.body);
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future setTaskUser(taskid, userid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/allocate-task-users/${taskid}/${userid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {
      print(e);
    }
  }

  static Future setTimerAttr(attr, value, context) async {
    try {
      print("------====");
      print(value);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
          Uri.parse('$uri/api/set-timer-attr/${attr}/${value}/${user.user_id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print(e);
    }
  }

  // static Future getTimerAttr(attr, context) async {
  //   try {
  //     print("------====");

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var token = prefs.getString('auth-token');
  //     var user = Provider.of<UserProvider>(context, listen: false).user;

  //     http.Response res = await http.get(
  //         Uri.parse('$uri/api/get-timer-attr/${user.user_id}/${attr}'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'authorization': 'Bearer ' + token.toString()
  //         });
  //     print(res.body);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static Future getTimerAttr(attr, context) async {
    try {
      print("------====");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
          Uri.parse('$uri/api/get-timer-attr/${user.user_id}/${attr}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      print(res.body);
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future reduceTurns(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.get(
          Uri.parse('$uri/api/reduce-turns/${user.user_id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
    } catch (e) {
      print("error in get task plans by plan");
    }
  }

  static Future getTaskPlansByPlan(taskplan) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-plan-by-plan/${taskplan}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print("error in get task plans by plan");
    }
  }

  static Future getEndTask(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user.user_id;
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-end-task/${user}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {
      print("error in get task plans by plan");
    }
  }

  static void setAlarm(date, time, id) async {
    var dat = date.split(" ")[0];
    Map<String, int> elements = getDateParts(dat);
    int year = elements['year'] ?? 2023;
    int month = elements['month'] ?? 11;
    int day = elements['date'] ?? 2;
    var tim = time;
    List<int> timlist = extractHourAndMinute(tim);
    int hour = timlist[0];
    int minute = timlist[1];
    try {
      print("alarm set at ${hour} ${year}");
      AndroidAlarmManager.oneShotAt(
          DateTime(year, month, day, hour, minute), id, () {
        print("hello");
      });
    } catch (e) {
      print(e);
    }
  }

  static Map<String, int> getDateParts(String dateString) {
    List<String> dateParts = dateString.split("-");
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    return {
      'year': year,
      'month': month,
      'day': day,
    };
  }

  static List<int> extractHourAndMinute(String time) {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return [hour, minute];
  }
}

import 'dart:convert';

import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class PomodoroTimerServices {
  static Future getTime(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user.user_id;
      print(user);
      var token = prefs.getString('auth-token');
      http.Response shortTimer = await http.get(
          Uri.parse('$uri/api/get-timer-attr/${user}/break_duration'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      http.Response longTimer = await http.get(
          Uri.parse('$uri/api/get-timer-attr/${user}/total_duration'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return {
        'duration': jsonDecode(longTimer.body)['value'],
        'break': jsonDecode(shortTimer.body)['value']
      };
    } catch (e) {
      print(e);
    }
  }

  static Future getTipsByDay(day)async{
     try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-tips-by-day/$day'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {}
  }
}

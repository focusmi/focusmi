import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focusmi/models/notification.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:focusmi/constants/global_variables.dart';

class NotiServices {
  static FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel name', 'd',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future ShowNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      await _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future createNotification(Notifications noti) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res =
          await http.post(Uri.parse('$uri/api/create-puser-notification'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ' + token.toString()
              },
              body: noti.toJson());
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getNotification(context) async {
    try {
      print("indeis");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-noti/${user.user_id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );

      print("-=-=-=");
      print(res.body);
      print("-=-=-=");
      return res;
    } catch (e) {
      print(e);
    }
  }
}

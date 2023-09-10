import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/error_handling.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/constants/utils.dart';
import 'package:focusmi/features/authentication/screens/auth-otp-insert.dart';
import 'package:focusmi/features/authentication/screens/choose-package.dart';
import 'package:focusmi/features/mainpage/screens/main_page.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/models/user.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup
  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      User user = User(
          user_id: 0,
          username: '',
          password: password,
          email: email,
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            print("sucess");
            showSuccessSnackBar(context, "Successful");
                        SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonDecode(res.body)[0]);
            await prefs.setString(
                'auth-token', (jsonDecode(res.body)[0])['token']);
            Navigator.pushNamed(context, MainScreen.routeName);
          });
    } catch (e) {
      //showErrorSnackBar(context, e.toString());
      print(e);
    }
  }

  void getUser({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response validity = await http
          .get(Uri.parse('$uri/api/is-token-valid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer ' + token.toString()
      });
      httpErrorHandle(
          response: validity,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonDecode(validity.body)[0]);
            Navigator.pushNamed(context, GroupList.routeName);
            var user = Provider.of<UserProvider>(context, listen: false).user;
            print(user.username);
          });
    } catch (e) {}
  }

  void createUser(
      {required String email,
      required String username,
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          email: email,
          username: username,
          password: password,
          user_id: 0,
          token: ' ');
      http.Response respnose = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: respnose,
          context: context,
          onSuccess: () async {
            showSuccessSnackBar(context, "Successful");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonDecode(respnose.body)[0]);
            await prefs.setString(
                'auth-token', (jsonDecode(respnose.body)[0])['token']);
            Navigator.pushNamed(context, OTPinsert.routeName);
          });
    } catch (e) {}
  }

  static void authenticateOTP(
      {required String otp, required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response respnose = await http.get(
          Uri.parse('$uri/api/verify-user/' + otp),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });

      httpErrorHandle(
          response: respnose,
          context: context,
          onSuccess: () async {
            if (respnose.body != false) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(jsonDecode(respnose.body)[0]);

              Navigator.pushNamed(context, ChoosePackage.routeName);
            }
          });
    } catch (e) {
      print("----------Error-----------");
      print(e);
    }
  }
}

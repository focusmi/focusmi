import 'package:therapist_app/constants/error_handling.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/features/auth/screens/auth_screen.dart';
import 'package:therapist_app/models/User.dart';
import 'package:therapist_app/provider/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widgets/bottom_bar.dart';

class AuthService {
  //signup
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    // try {
    //   User user =
    //       User(id: 0, name: name, email: email, password: password, token: '');

    //   final String userJson = jsonEncode(user); // Serialize user to JSON string

    //   http.Response res = await http.post(
    //     Uri.parse('$uri/apis/signup'),
    //     body: userJson,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );

    //   httpErrorHandle(
    //     response: res,
    //     context: context,
    //     onSuccess: () {
    //       showSnackBar(context, 'Account has been created');
    //     },
    //   );
    // } catch (err) {
    //   showSnackBar(context, err.toString());
    // }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/apis/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavBarRoots()),
            (route) => false,
          );
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> updateUser({
    required BuildContext context,
    required String field,
    required String value,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      final User updatedUser = User(
        id: user.id,
        name: field == 'Full Name' ? value : user.name,
        email: field == 'Email' ? value : user.email,
        mobile: field == 'Mobile Number' ? value : user.mobile,
        clients: field == 'Total Clients' ? int.parse(value) : user.clients,
        experience: field == 'Experience' ? value : user.experience,
        password: user.password,
        token: user.token,
        about: field == 'About' ? value : user.about,
        status: user.status,
      );

      final res = await http.put(
        Uri.parse('$uri/apis/user/${user.id}'),
        body: jsonEncode({
          'user_id': updatedUser.id,
          'full_name': updatedUser.name,
          'email': updatedUser.email,
          'password': updatedUser.password,
          'tot_clients': updatedUser.clients,
          'about': updatedUser.about,
          'years_of_experience': updatedUser.experience,
          'phone_number': updatedUser.mobile,
          'account_status': updatedUser.status,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              user.token, // Include the authentication token in the headers
        },
      );

      if (res.statusCode == 200) {
        // Update the user in the user provider
        userProvider.setUser(res.body);
        showSnackBar(context, 'User data updated successfully');
        getUserData(context);
      } else {
        showSnackBar(context, 'Failed to update user data');
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  static Future<bool> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      final response = await http.put(
        Uri.parse('$uri/apis/user/${user.id}/change-password'),
        body: jsonEncode({
          'currentPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error'] ?? 'Failed to change password';
        // throw Exception(errorMessage);
        showSnackBar(context, errorMessage);
        return false;
      }
    } catch (error) {
      print('Error changing password: $error');
      return false;
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}

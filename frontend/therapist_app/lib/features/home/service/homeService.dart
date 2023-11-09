import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/provider/user_provider.dart';

class HomeService {
  static Future<bool> updateUserState({
    required String state,
    required BuildContext context,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      final response = await http.put(
        Uri.parse('$uri/apis/user/update-state/${user.id}'),
        body: jsonEncode({
          'state': state,
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
        final errorMessage = errorBody['error'] ?? 'Failed to update state';
        throw Exception(errorMessage);
      }
    } catch (error) {
      return false;
    }
  }

  static Future<String> getScheduleCount({
    required BuildContext context,
    }) async { 
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      final response = await http.get(
        Uri.parse('$uri/apis/schedule/count/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load schedule count data');
      }
    } catch (e) {
      throw Exception('Error fetching schedule data: $e');
    }
  }
}

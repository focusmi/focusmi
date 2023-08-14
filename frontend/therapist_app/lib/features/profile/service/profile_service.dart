import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/provider/user_provider.dart';

class ProfileService {
  static Future<bool> uploadProfilePicture(
      BuildContext context, File imageFile) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$uri/apis/upload-profile-pic/${user.id}'));

      // Include the authentication token in the headers
      request.headers['x-auth-token'] = user.token;

      request.files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));
      var response = await request.send();

      return response.statusCode == 200;
    } catch (error) {
      print('Error uploading profile picture: $error');
      return false;
    }
  }

  static Future<String?> loadProfilePictureUrl(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    try {
      final response = await http.get(
        Uri.parse('$uri/apis/user/profile-picture/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['profile_image']; // Update with the actual field name returned by the server
      } else {
        print('Failed to load profile picture');
        return null;
      }
    } catch (error) {
      print('Error loading profile picture: $error');
      return null;
    }
  }
}

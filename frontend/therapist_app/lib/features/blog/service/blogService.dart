import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BlogService {
  Future<void> addBlogDataAndImage(Map<String, dynamic> blogData,
      BuildContext context, File imageFile) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$uri/apis/user/add-blog/${user.id}'),
      );
      request.headers['x-auth-token'] = user.token;

      // Add blog data fields
      request.fields['title'] = blogData['title'];
      request.fields['description'] = blogData['desc'];
      request.fields['sub_title'] = blogData['sub_title'];

      // Add the image file
      request.files
          .add(await http.MultipartFile.fromPath('blog_image', imageFile.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        showSnackBar(context, 'Blog data uploaded successfully');
      } else {
        final errorBody = await response.stream.bytesToString();
        final errorMessage =
            jsonDecode(errorBody)['error'] ?? 'Failed to add blog';
        showSnackBar(context, errorMessage);
      }
    } catch (error) {
      print('Error adding blog data and image: $error');
    }
  }

  static Future<List<dynamic>> getData(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      final response = await http.get(
        Uri.parse('$uri/apis/user/fetch-blog/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error fetching blogs data: $e');
    }
  }

  static Future<bool> deleteBlog({
    required int blog_id,
    required BuildContext context,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      final response = await http.delete(
        Uri.parse('$uri/apis/user/${user.id}/delete-blog/${blog_id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      if (response.statusCode == 200) {
        showSnackBar(context, "Blog deleted");
        return true;
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error'] ?? 'Failed to delete blog';
        showSnackBar(context, errorMessage);
        return false;
      }
    } catch (error) {
      print('Error deleting blog: $error');
      return false;
    }
  }

  Future<void> updateBlogDataAndImage(Map<String, dynamic> blogData,
      BuildContext context, File imageFile) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      print('$uri/apis/user/${user.id}/edit-blog/${blogData['blogID']}');
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$uri/apis/user/${user.id}/edit-blog/${blogData['blogID']}'),
      );
      request.headers['x-auth-token'] = user.token;

      // Add blog data fields
      request.fields['title'] = blogData['title'];
      request.fields['description'] = blogData['desc'];
      request.fields['sub_title'] = blogData['sub_title'];

      // Add the image file
      request.files
          .add(await http.MultipartFile.fromPath('blog_image', imageFile.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        showSnackBar(context, 'Blog data updated successfully');
      } else {
        final errorBody = await response.stream.bytesToString();
        final errorMessage =
            jsonDecode(errorBody)['error'] ?? 'Failed to update blog';
        showSnackBar(context, errorMessage);
      }
    } catch (error) {
      print('Error updating blog data and image: $error');
    }
  }
}

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MindFMainPageServices {
  static Future getSimilarContent(course) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-similar-courses/${course}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
      print("------------");
      print('$uri/api/get-similar-courses/${course}');
      print("------------");

      return res;
    } catch (e) {}
  }

  static Future getTherapists() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-therapist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getUserPackage(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user.user_id;
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-user-package/${user}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
    
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future setUserPackage(context,package) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      var user = Provider.of<UserProvider>(context, listen: false).user.user_id;
      http.Response res = await http.get(
        Uri.parse('$uri/api/set-user-package/${package}/${user}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
    
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future getCourseLevels(levelid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-course-level/${levelid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
      return res;
    } catch (e) {}
  }
}

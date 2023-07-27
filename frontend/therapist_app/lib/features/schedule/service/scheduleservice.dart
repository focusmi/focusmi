import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';

class ScheduleService {
  static Future<List<dynamic>> getScheduleDataForUser(
      int userId, String userToken) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/apis/schedule/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load schedule data');
      }
    } catch (e) {
      throw Exception('Error fetching schedule data: $e');
    }
  }
}

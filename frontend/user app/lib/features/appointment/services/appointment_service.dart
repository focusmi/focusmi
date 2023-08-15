import 'dart:convert';
import 'dart:ffi';

import 'package:focusmi/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  static Future<List<dynamic>> getCouncillorList() async {
    try {
        print('$uri/api/customer');
      final response = await http.get(
        Uri.parse('$uri/api/customer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the data from the response
        List<dynamic> data = json.decode(response.body);

        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  static Future<List<dynamic>> getTimeSlotList(userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.18:3001/api/get_time_slots/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the data from the response
        List<dynamic> data = json.decode(response.body);

        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  static Future<void> updateSession(int sessionId, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.18:3001/api/update_session/$userId'),
        body: jsonEncode({'sessionId': sessionId, 'userId': userId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the data from the respons
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

import 'dart:convert';
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
        Uri.parse('$uri/api/get_time_slots/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the data from the response
        List<dynamic> data = json.decode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  static updateSession(int sessionId, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/update_session/'),
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

  static Future<List<dynamic>> getAppointments(userId) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/view_appointments/$userId'),
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

  static Future<List<dynamic>> getAppointmentDetails(sessionId) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/full_appointment_details/$sessionId'),
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

  static Future<List<dynamic>> getCouncillorDetails(userId) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/councillor_details/$userId'),
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

  // static Future<List<dynamic>> getPreviousAppointments(userId) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$uri/api/previous_appointments/$userId'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       // Parse and return the data from the response
  //       return json.decode(response.body);
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

  static Future<List<dynamic>> getPreviousAppointments(userId) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/previous_appointments/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load schedule data');
      }
    } catch (e) {
      throw Exception('Error fetching schedule data: $e');
    }
  }
}

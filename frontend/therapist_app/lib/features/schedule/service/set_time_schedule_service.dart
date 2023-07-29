import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/provider/user_provider.dart';

class TimeRange {
  final BuildContext context;
  final DateTime start;
  final DateTime end;

  TimeRange({required this.context, required this.start, required this.end});

  String formatTimeRange() {
    return '${TimeOfDay.fromDateTime(start).format(context)} - ${TimeOfDay.fromDateTime(end).format(context)}';
  }

  Schedule toSchedule() {
    return Schedule(
      start: start,
      end: end,
    );
  }
}

class SetTimeScheduleService {
  static Future<List<Schedule>> fetchSchedules(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final response = await http.get(
      Uri.parse('$uri/apis/schedule/time/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token,
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      // print(jsonData);

      if (jsonData == null) {
        // Return an empty list if the response body is null
        return [];
      }

      if (jsonData is List) {
        // Handle the case where the response is a list of schedules
        return jsonData.map((data) => Schedule.newFromJson(data)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        // Handle the case where the response is a single schedule object
        return [Schedule.fromJson(jsonData)];
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to fetch schedules');
    }
  }

  static Future<void> createSchedule(
      Schedule schedule, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    final body = jsonEncode(schedule.toJson());

    final response = await http.post(
      Uri.parse('$uri/apis/schedule/create/${user.id}'),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create schedule');
    }
  }
}

class Schedule {
  final DateTime start;
  final DateTime end;

  Schedule({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }
  
  factory Schedule.newFromJson(Map<String, dynamic> json) {
    return Schedule(
      start: DateTime.parse(json['session_time']),
      end: DateTime.parse(json['session_end_time']),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int task_id;
  int plan_id;
  int? timer_id;
  String task_name;
  int? duration;
  String? task_status;
  int? priority;
  String? task_type;
  String? created_at;
  String? color;
  String? description;
  bool? is_text_field;
  String? deadline_date;
  String? deadline_time;
  String? reminder_time;
  String? reminder_date;
  String? location;

  Task({
    required this.task_id,
    required this.plan_id,
    required this.timer_id,
    required this.task_name,
    required this.duration,
    required this.task_status,
    required this.priority,
    required this.task_type,
    required this.created_at,
    required this.color,
    required this.description,
    required this.is_text_field,
    this.deadline_date,
    this.deadline_time,
    this.reminder_time,
    this.reminder_date,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': task_id,
      'plan_id': plan_id,
      'timer_id': timer_id,
      'task_name': task_name,
      'duration': duration,
      'task_status': task_status,
      'priority': priority,
      'task_type': task_type,
      'created_at': created_at,
      'color': color,
      'description': description,
      'is_text_field': is_text_field,
      'deadline_date': deadline_date,
      'deadline_time': deadline_time,
      'reminder_time': reminder_time,
      'reminder_date': reminder_date,
      'location': location,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task_id: map['task_id'] as int,
      plan_id: map['plan_id'] as int,
      timer_id: map['timer_id'] != null ? map['timer_id'] as int : null,
      task_name: map['task_name'] as String,
      duration: map['duration'] != null ? map['duration'] as int : null,
      task_status: map['task_status'] != null ? map['task_status'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      task_type: map['task_type'] != null ? map['task_type'] as String : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      is_text_field: map['is_text_field'] != null ? map['is_text_field'] as bool : null,
      deadline_date: map['deadline_date'] != null ? map['deadline_date'] as String : null,
      deadline_time: map['deadline_time'] != null ? map['deadline_time'] as String : null,
      reminder_time: map['reminder_time'] != null ? map['reminder_time'] as String : null,
      reminder_date: map['reminder_date'] != null ? map['reminder_date'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(Map<String, dynamic> source) =>
      Task.fromMap(source as Map<String, dynamic>);

}

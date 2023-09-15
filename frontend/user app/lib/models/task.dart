
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
  String? created_at;
  String? color;
  String? description;
  bool? is_text_field;
  
  Task({
    required this.task_id,
    required this.plan_id,
    required this.timer_id,
    required this.task_name,
    required this.duration,
    required this.task_status,
    required this.priority,
    required this.created_at,
    required this.color,
    required this.description,
    required this.is_text_field,
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
      'created_at': created_at,
      'color': color,
      'description': description,
      'is_text_field': is_text_field,
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
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      is_text_field: map['is_text_field'] != null ? map['is_text_field'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  
  factory Task.fromJson(Map<String, dynamic> source) => Task.fromMap(source as Map<String, dynamic>);



}

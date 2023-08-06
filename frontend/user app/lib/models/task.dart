// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final int task_id;
  int plan_id;
  final int timer_id;
  final String task_name;
  final int duration;
  final String task_status;
  final int priority;
  final String created_date;
  final String created_time;
  final String completed_date;
  final String completed_time;
  final String color;
  final String description;
  bool is_text_field;
  
  Task({
    required this.task_id,
    required this.plan_id,
    required this.timer_id,
    required this.task_name,
    required this.duration,
    required this.task_status,
    required this.priority,
    required this.created_date,
    required this.created_time,
    required this.completed_date,
    required this.completed_time,
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
      'created_date': created_date,
      'created_time': created_time,
      'completed_date': completed_date,
      'completed_time': completed_time,
      'color': color,
      'description': description,
      'is_text_field': is_text_field,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task_id: map['task_id'] as int,
      plan_id: map['plan_id'] as int,
      timer_id: map['timer_id'] as int,
      task_name: map['task_name'] as String,
      duration: map['duration'] as int,
      task_status: map['task_status'] as String,
      priority: map['priority'] as int,
      created_date: map['created_date'] as String,
      created_time: map['created_time'] as String,
      completed_date: map['completed_date'] as String,
      completed_time: map['completed_time'] as String,
      color: map['color'] as String,
      description: map['description'] as String,
      is_text_field: map['is_text_field'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  getTask(plan_id){
    return [];
  }
}

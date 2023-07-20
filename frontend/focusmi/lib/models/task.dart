// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final int task_ID;
  final int plan_ID;
  final int timer_ID;
  final int duration;
  final String task_status;
  final String priority;
  final String created_date;
  final String created_time;
  final String completed_date;
  final String completed_time;
  final String color;
  final String description;
  
  Task({
    required this.task_ID,
    required this.plan_ID,
    required this.timer_ID,
    required this.duration,
    required this.task_status,
    required this.priority,
    required this.created_date,
    required this.created_time,
    required this.completed_date,
    required this.completed_time,
    required this.color,
    required this.description,
  });

 
  
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_ID': task_ID,
      'plan_ID': plan_ID,
      'timer_ID': timer_ID,
      'duration': duration,
      'task_status': task_status,
      'priority': priority,
      'created_date': created_date,
      'created_time': created_time,
      'completed_date': completed_date,
      'completed_time': completed_time,
      'color': color,
      'description': description,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task_ID: map['task_ID'] as int,
      plan_ID: map['plan_ID'] as int,
      timer_ID: map['timer_ID'] as int,
      duration: map['duration'] as int,
      task_status: map['task_status'] as String,
      priority: map['priority'] as String,
      created_date: map['created_date'] as String,
      created_time: map['created_time'] as String,
      completed_date: map['completed_date'] as String,
      completed_time: map['completed_time'] as String,
      color: map['color'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  getTask(plan_ID){
    return [];
  }
}

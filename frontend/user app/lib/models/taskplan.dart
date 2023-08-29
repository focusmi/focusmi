// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskPlan {
  final int plan_id;
  final int group_id;
  String plan_name;
  final String location;
  final String schedule_date; 
  final String schedule_type;
  final String time;
  final String reminder_status;
  final String created_date;
  bool? is_edit;

  TaskPlan({
    required this.plan_id,
    required this.group_id,
    required this.plan_name,
    required this.location,
    required this.schedule_date,
    required this.schedule_type,
    required this.time,
    required this.reminder_status,
    required this.created_date,
    this.is_edit
  });
  
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'plan_id': plan_id,
      'group_id': group_id,
      'plan_name': plan_name,
      'location': location,
      'schedule_date': schedule_date,
      'schedule_type': schedule_type,
      'time': time,
      'reminder_status': reminder_status,
      'created_date': created_date,
    };
  }

  factory TaskPlan.fromMap(Map<String, dynamic> map) {
    return TaskPlan(
      plan_id: map['plan_id'] as int,
      group_id: map['group_id'] as int,
      plan_name: map['plan_name'] as String,
      location: map['location'] as String,
      schedule_date: map['schedule_date'] as String,
      schedule_type: map['schedule_type'] as String,
      time: map['time'] as String,
      reminder_status: map['reminder_status'] as String,
      created_date: map['created_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskPlan.fromJson(String source) => TaskPlan.fromMap(json.decode(source) as Map<String, dynamic>);

  

}

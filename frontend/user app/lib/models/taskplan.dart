// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskPlan {
  final int plan_id;
  final int? group_id;
  String plan_name;
  final String? location;
  final String? schedule_date; 
  final String? schedule_type;
  final String? time;
  final String? reminder_status;
  final String? created_date;
  bool? is_edit;

  TaskPlan({
    required this.plan_id,
     this.group_id,
    required this.plan_name,
    this.location,
    this.schedule_date,
    this.schedule_type,
    this.time,
    this.reminder_status,
    this.created_date,
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
      'is_edit': is_edit,
    };
  }

  factory TaskPlan.fromMap(Map<String, dynamic> map) {
    return TaskPlan(
      plan_id: map['plan_id'] as int,
      group_id: map['group_id'] != null ? map['group_id'] as int : null,
      plan_name: map['plan_name'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      schedule_date: map['schedule_date'] != null ? map['schedule_date'] as String : null,
      schedule_type: map['schedule_type'] != null ? map['schedule_type'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      reminder_status: map['reminder_status'] != null ? map['reminder_status'] as String : null,
      created_date: map['created_date'] != null ? map['created_date'] as String : null,
      is_edit: map['is_edit'] != null ? map['is_edit'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskPlan.fromJson(Map<String, dynamic> source) => TaskPlan.fromMap(source as Map<String, dynamic>);

  


}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubTask {
  final int stack_id;
  final int task_id;
  final int sub_priority;
  final String sub_label;
  final String sub_status;
  final String created_at;

  SubTask({
    required this.stack_id, 
    required this.task_id, 
    required this.sub_priority, 
    required this.sub_label, 
    required this.sub_status, 
    required this.created_at
    });

  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stack_id': stack_id,
      'task_id': task_id,
      'sub_priority': sub_priority,
      'sub_label': sub_label,
      'sub_status': sub_status,
      'created_at': created_at,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      stack_id: map['stack_id'] as int,
      task_id: map['task_id'] as int,
      sub_priority: map['sub_priority'] as int,
      sub_label: map['sub_label'] as String,
      sub_status: map['sub_status'] as String,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) => SubTask.fromMap(json.decode(source) as Map<String, dynamic>);
}




// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubTask {
  final int? stask_id;
  final int? task_id;
  final String? sub_priority;
  final String? sub_label;
  final String? sub_status;
  final String? created_at;

  SubTask({
    this.stask_id,
    required this.task_id,
    required this.sub_priority,
    required this.sub_label,
    required this.sub_status,
    required this.created_at
  });

  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stask_id': stask_id,
      'task_id': task_id,
      'sub_priority': sub_priority,
      'sub_label': sub_label,
      'sub_status': sub_status,
      'created_at': created_at,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      stask_id: map['stask_id'] != null ? map['stask_id'] as int : null,
      task_id: map['task_id'] != null ? map['task_id'] as int : null,
      sub_priority: map['sub_priority'] != null ? map['sub_priority'] as String : null,
      sub_label: map['sub_label'] != null ? map['sub_label'] as String : null,
      sub_status: map['sub_status'] != null ? map['sub_status'] as String : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(Map<String, dynamic> source) =>SubTask.fromMap(source as Map<String, dynamic>);


}




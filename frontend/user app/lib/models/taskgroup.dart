import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskGroup {
  final int group_id;
  final String group_name;
  final String status;
  final String member_count;
  final int creator_id;
  final String created_at;
  

  TaskGroup({
    required this.group_id,
    required this.group_name,
    required this.status,
    required this.member_count,
    required this.creator_id,
    required this.created_at,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group_id': group_id,
      'group_name': group_name,
      'status': status,
      'member_count': member_count,
      'creator_id': creator_id,
      'created_at': created_at,
    };
  }

  factory TaskGroup.fromMap(Map<String, dynamic> map) {
    return TaskGroup(
      group_id: map['group_id'] as int,
      group_name: map['group_name'] as String,
      status: map['status'] as String,
      member_count: map['member_count'] as String,
      creator_id: map['creator_id'] as int,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskGroup.fromJson(Map<String, dynamic> source) => TaskGroup.fromMap(source as Map<String, dynamic>);
  


}

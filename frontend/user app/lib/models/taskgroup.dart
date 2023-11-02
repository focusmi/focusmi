import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskGroup {
  final int? group_id;
  final String? group_name;
  final String? status;
  final String? member_count;
  String? description;
  final int? creator_id;
  final String? created_at;

  TaskGroup({
    required this.group_id,
    required this.group_name,
    required this.status,
    required this.member_count,
    this.description,
    required this.creator_id,
    required this.created_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group_id': group_id,
      'group_name': group_name,
      'status': status,
      'member_count': member_count,
      'description': description,
      'creator_id': creator_id,
      'created_at': created_at,
    };
  }

  factory TaskGroup.fromMap(Map<String, dynamic> map) {
    return TaskGroup(
      group_id: map['group_id'] != null ? map['group_id'] as int : null,
      group_name: map['group_name'] != null ? map['group_name'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      member_count: map['member_count'] != null ? map['member_count'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      creator_id: map['creator_id'] != null ? map['creator_id'] as int : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskGroup.fromJson(Map<String, dynamic> source) =>
      TaskGroup.fromMap(source as Map<String, dynamic>);



}

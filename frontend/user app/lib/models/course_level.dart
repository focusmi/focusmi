// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MindfulnessCourseLevel {
  final int? course_id;
  final int? level_id;
  final String? level_name;
  final String? level_description;
  final String? reference;
  final String? media_type;
  final String? content_location;

  MindfulnessCourseLevel({
    required this.course_id,
    this.level_id,
    this.level_name,
    this.level_description,
    this.reference,
    this.media_type,
    this.content_location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'course_id': course_id,
      'level_id': level_id,
      'level_name': level_name,
      'level_description': level_description,
      'reference': reference,
      'media_type': media_type,
      'content_location': content_location,
    };
  }

  factory MindfulnessCourseLevel.fromMap(Map<String, dynamic> map) {
    return MindfulnessCourseLevel(
      course_id: map['course_id'] != null ? map['course_id'] as int : null,
      level_id: map['level_id'] != null ? map['level_id'] as int : null,
      level_name: map['level_name'] != null ? map['level_name'] as String : null,
      level_description: map['level_description'] != null ? map['level_description'] as String : null,
      reference: map['reference'] != null ? map['reference'] as String : null,
      media_type: map['media_type'] != null ? map['media_type'] as String : null,
      content_location: map['content_location'] != null ? map['content_location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory MindfulnessCourseLevel.fromJson(Map<String, dynamic> source) =>
      MindfulnessCourseLevel.fromMap(source as Map<String, dynamic>);



}

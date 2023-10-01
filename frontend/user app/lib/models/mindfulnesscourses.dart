// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MindfulnessCourse {
  final int? course_id;
  final String? author;
  final String? image;
  final String? title;
  final String? decription;
  final String? subtitle;
  final String? user_category;
  final String? objective_type;
  final String? course_type;
  final String? remarks;
  final int? likes;

  MindfulnessCourse({
    required this.course_id,
    required this.author,
    required this.image,
    required this.title,
    required this.decription,
    required this.subtitle,
    required this.user_category,
    required this.objective_type,
    required this.course_type,
    required this.remarks,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'course_id': course_id,
      'author': author,
      'image': image,
      'title': title,
      'decription': decription,
      'subtitle': subtitle,
      'user_category': user_category,
      'objective_type': objective_type,
      'course_type': course_type,
      'remarks': remarks,
      'likes': likes,
    };
  }

  factory MindfulnessCourse.fromMap(Map<String, dynamic> map) {
    return MindfulnessCourse(
      course_id: map['course_id'] != null ? map['course_id'] as int : null,
      author: map['author'] != null ? map['author'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      decription: map['decription'] != null ? map['decription'] as String : null,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      user_category: map['user_category'] != null ? map['user_category'] as String : null,
      objective_type: map['objective_type'] != null ? map['objective_type'] as String : null,
      course_type: map['course_type'] != null ? map['course_type'] as String : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
      likes: map['likes'] != null ? map['likes'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory MindfulnessCourse.fromJson(Map<String, dynamic> source) =>
      MindfulnessCourse.fromMap(source as Map<String, dynamic>);

}

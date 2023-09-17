// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MindfulnessCourse {
  final int course_id;
  final String author;
  final String image;
  final String title;
  final String decription;
  final String subtitle;
  final String user_category;
  final String objective_type;
  final String course_type;
  final String remarks;
  final int likes;

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
      course_id: map['course_id'] as int,
      author: map['author'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      decription: map['decription'] as String,
      subtitle: map['subtitle'] as String,
      user_category: map['user_category'] as String,
      objective_type: map['objective_type'] as String,
      course_type: map['course_type'] as String,
      remarks: map['remarks'] as String,
      likes: map['likes'] as int,
    );
  }

  String toJson() => json.encode(toMap());
  factory MindfulnessCourse.fromJson(Map<String, dynamic> source) =>
      MindfulnessCourse.fromMap(source as Map<String, dynamic>);
}

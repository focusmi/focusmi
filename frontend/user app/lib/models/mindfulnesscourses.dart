// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MindfulnessCourse {
  final int? course_id;
  final String? image;
  final String? title;
  final String? description;
  final String? skill;
  final String? course_type;
  final String? subscription_type;
  final String? course_status;
  final int? ratings;
  final int? duration;

  MindfulnessCourse({
    required this.course_id,
    required this.image,
    required this.title,
    this.description,
    this.skill,
    required this.course_type,
    this.subscription_type,
    this.course_status,
    this.ratings,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'course_id': course_id,
      'image': image,
      'title': title,
      'description': description,
      'skill': skill,
      'course_type': course_type,
      'subscription_type': subscription_type,
      'course_status': course_status,
      'ratings': ratings,
      'duration': duration,
    };
  }

  factory MindfulnessCourse.fromMap(Map<String, dynamic> map) {
    return MindfulnessCourse(
      course_id: map['course_id'] != null ? map['course_id'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      skill: map['skill'] != null ? map['skill'] as String : null,
      course_type: map['course_type'] != null ? map['course_type'] as String : null,
      subscription_type: map['subscription_type'] != null ? map['subscription_type'] as String : null,
      course_status: map['course_status'] != null ? map['course_status'] as String : null,
      ratings: map['ratings'] != null ? map['ratings'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory MindfulnessCourse.fromJson(Map<String, dynamic> source) =>
      MindfulnessCourse.fromMap(source as Map<String, dynamic>);


}

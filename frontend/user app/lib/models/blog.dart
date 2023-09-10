// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Blog {
  final int user_id;
  final String title;
  final String subtitle;
  final String description;

  Blog(this.user_id, this.title, this.subtitle, this.description);
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      map['user_id'] as int,
      map['title'] as String,
      map['subtitle'] as String,
      map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(Map<String, dynamic> source) => Blog.fromMap(source as Map<String, dynamic>);
}

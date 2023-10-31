// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DailyTips {
  final int tip_id;
  final String? day;
  final String? text;
  final String? content_location;

  DailyTips(
    this.tip_id,
    this.day,
    this.text,
    this.content_location,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tip_id': tip_id,
      'day': day,
      'text': text,
      'content_location': content_location,
    };
  }

  factory DailyTips.fromMap(Map<String, dynamic> map) {
    return DailyTips(
      map['tip_id'] as int,
      map['day'] != null ? map['day'] as String : null,
      map['text'] != null ? map['text'] as String : null,
      map['content_location'] != null ? map['content_location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyTips.fromJson(Map<String, dynamic> source) =>
      DailyTips.fromMap(source as Map<String, dynamic>);

}

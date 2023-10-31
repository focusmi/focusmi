import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessage {
  int? message_id;
  int? user_id;
  int? chat_id;
  int? group_id;
  String message_text;
  String message_type;
  String? image;
  String? create_time;

  ChatMessage({
    this.message_id,
    this.user_id,
    this.chat_id,
    this.group_id,
    required this.message_text,
    required this.message_type,
    this.image,
    this.create_time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message_id': message_id,
      'user_id': user_id,
      'chat_id': chat_id,
      'group_id': group_id,
      'message_text': message_text,
      'message_type': message_type,
      'image': image,
      'create_time': create_time,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message_id: map['message_id'] != null ? map['message_id'] as int : null,
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      chat_id: map['chat_id'] != null ? map['chat_id'] as int : null,
      group_id: map['group_id'] != null ? map['group_id'] as int : null,
      message_text: map['message_text'] as String,
      message_type: map['message_type'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      create_time: map['create_time'] != null ? map['create_time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory ChatMessage.fromJson(Map<String, dynamic> source) =>ChatMessage.fromMap(source as Map<String, dynamic>);
}

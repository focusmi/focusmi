import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notifications {
  int? noti_id;
  int? user_id;
  String? text;
  String? type;
  String? status;
  int? task_id;
  int? payement_id;
  int? group_id;

  Notifications({
    this.noti_id,
    this.user_id,
    this.text,
    this.type,
    this.status,
    this.task_id,
    this.payement_id,
    this.group_id,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'noti_id': noti_id,
      'user_id': user_id,
      'text': text,
      'type': type,
      'status': status,
      'task_id': task_id,
      'payement_id': payement_id,
      'group_id': group_id,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      noti_id: map['noti_id'] != null ? map['noti_id'] as int : null,
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      task_id: map['task_id'] != null ? map['task_id'] as int : null,
      payement_id: map['payement_id'] != null ? map['payement_id'] as int : null,
      group_id: map['group_id'] != null ? map['group_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(Map<String, dynamic> source) =>Notifications.fromMap(source as Map<String, dynamic>);
}

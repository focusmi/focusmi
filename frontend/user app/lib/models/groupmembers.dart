// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupMember {
  final int user_id;
  final String username;
  final String email;
  final String? account_status;
  final String? profile_image;

  GroupMember(this.user_id, this.username, this.email, this.account_status, this.profile_image);
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'username': username,
      'email': email,
      'account_status': account_status,
      'profile_image': profile_image,
    };
  }

  factory GroupMember.fromMap(Map<String, dynamic> map) {
    return GroupMember(
      map['user_id'] as int,
      map['username'] as String,
      map['email'] as String,
      map['account_status'] as String?,
      map['profile_image'] as String?,
    );
  }

  String toJson() => json.encode(toMap());
  factory GroupMember.fromJson(Map<String, dynamic> source) => GroupMember.fromMap(source as Map<String, dynamic>);


}

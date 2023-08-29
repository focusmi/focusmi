import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int user_id;
  final String username;
  final String email;
  final String password;
  final String token;
  
  User({
    required this.user_id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  
  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source as Map<String, dynamic>);
}

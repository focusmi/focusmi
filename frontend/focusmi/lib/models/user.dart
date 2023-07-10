import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String token;
  
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
  });

Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

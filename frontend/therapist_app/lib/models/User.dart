import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  // final String address;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.address,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'admin_user_ID': id,
      'user_name': name,
      'email': email,
      'password': password,
      // 'address': address,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['admin_user_ID'] ?? 0,
      name: map['user_name'].toString() ?? '',
      email: map['email'].toString() ?? '',
      password: map['password'].toString() ?? '',
      token: map['token'].toString() ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) {
    Map<String, dynamic> map = json.decode(source);
    return User.fromMap(map);
  }
}

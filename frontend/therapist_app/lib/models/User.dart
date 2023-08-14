import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final int clients;
  final String experience;
  final String about;
  final String status;
  // final String address;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.address,
    required this.mobile,
    required this.clients,
    required this.experience,
    required this.about,
    required this.status,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': id,
      'full_name': name,
      'email': email,
      'password': password,
      // 'address': address,
      'tot_clients': clients,
      'about': about,
      'years_of_experience': experience,
      'phone_number': mobile,
      'account_status': status,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['user_id'] ?? 0,
        name: map['full_name'].toString() ?? '',
        email: map['email'].toString() ?? '',
        password: map['password'].toString() ?? '',
        token: map['token'].toString() ?? '',
        clients: map['tot_clients'] ?? 0,
        about: map['about'].toString() ?? '',
        experience: map['years_of_experience'] ?? '',
        mobile: map['phone_number'].toString() ?? '',
        status: map['account_status'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) {
    Map<String, dynamic> map = json.decode(source);
    return User.fromMap(map);
  }
}

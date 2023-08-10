import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final int clients;
  final int experience;
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
      'admin_user_ID': id,
      'user_name': name,
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
        id: map['admin_user_ID'] ?? 0,
        name: map['user_name'].toString() ?? '',
        email: map['email'].toString() ?? '',
        password: map['password'].toString() ?? '',
        token: map['token'].toString() ?? '',
        clients: map['tot_clients'] ?? 0,
        about: map['about'].toString() ?? '',
        experience: map['years_of_experience'] ?? 0,
        mobile: map['phone_number'].toString() ?? '',
        status: map['account_status'] ?? 'offline');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) {
    Map<String, dynamic> map = json.decode(source);
    print(map);
    return User.fromMap(map);
  }
}

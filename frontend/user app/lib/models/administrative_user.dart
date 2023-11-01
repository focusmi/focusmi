import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdministrativeUser {
  int? user_id;
  String? username;
  String? full_name;
  String? role;
  String? email;
  String? phone_number;
  String? about;
  String? account_status;
  String? years_of_experience;
  int? tot_clients;
  String? password;
  String? title;
  String? image;
  String? nic;
  AdministrativeUser({
    this.user_id,
    this.username,
    this.full_name,
    this.role,
    this.email,
    this.phone_number,
    this.about,
    this.account_status,
    this.years_of_experience,
    this.tot_clients,
    this.password,
    this.title,
    this.image,
    this.nic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'username': username,
      'full_name': full_name,
      'role': role,
      'email': email,
      'phone_number': phone_number,
      'about': about,
      'account_status': account_status,
      'years_of_experience': years_of_experience,
      'tot_clients': tot_clients,
      'password': password,
      'title': title,
      'image': image,
      'nic': nic,
    };
  }

  factory AdministrativeUser.fromMap(Map<String, dynamic> map) {
    return AdministrativeUser(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone_number: map['phone_number'] != null ? map['phone_number'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      account_status: map['account_status'] != null ? map['account_status'] as String : null,
      years_of_experience: map['years_of_experience'] != null ? map['years_of_experience'] as String : null,
      tot_clients: map['tot_clients'] != null ? map['tot_clients'] as int : null,
      password: map['password'] != null ? map['password'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['profile_image'] != null ? map['profile_image'] as String : null,
      nic: map['nic'] != null ? map['nic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());


  factory  AdministrativeUser.fromJson(Map<String, dynamic> source) => AdministrativeUser.fromMap(source as Map<String, dynamic>);
}

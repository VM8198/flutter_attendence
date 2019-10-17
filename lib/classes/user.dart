import 'package:json_annotation/json_annotation.dart';

class User {
  @JsonKey(name: '_id')
  final String id;
  final String userRole;
  final String email;
  final String name;
  final String designation;
  final String password;

  User(
      {this.id,
      this.userRole,
      this.email,
      this.name,
      this.designation,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userRole: json['userRole'] as String,
      id: json['_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      password: json['password'] as String,
    );
  }
}

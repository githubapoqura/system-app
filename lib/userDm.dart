
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  final String phone;
  final String email;
  final DateTime createdAt;

  UserModel({
    this.id,
    required this.phone,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phoneNumber'],
      email: json['email'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phone,
      'email': email,
      'createdAt': createdAt,
    };
  }
}

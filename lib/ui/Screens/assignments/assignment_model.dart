import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final String title;
  final String description;
  final String doctorName;
  final DateTime expireDate;
  String? achieveLink;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.doctorName,
    required this.expireDate,
    this.achieveLink,
  });

  factory Assignment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Assignment(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      doctorName: data['doctorName'] ?? '',
      expireDate: (data['expireDate'] as Timestamp).toDate(),
      achieveLink: data['achieveLink'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'doctorName': doctorName,
      'expireDate': Timestamp.fromDate(expireDate),
      'achieveLink': achieveLink,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'achieveLink': achieveLink,
    };
  }
}
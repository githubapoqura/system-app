import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String id;
  String title;
  String describtion;
  DateTime date;
  String link;

  ProjectModel({
    this.id = '',
    required this.title,
    required this.describtion,
    required this.date,
    required this.link,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json, String id) {
    return ProjectModel(
      id: id,
      title: json['title'],
      describtion: json['describtion'],
      link: json['link'],
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'describtion': describtion,
      'link': link,
      'date': Timestamp.fromDate(date),
    };
  }

  ProjectModel copyWith({
    String? id,
    String? updatedTitle,
    String? updatedDescription,
    String? updatedLink,
    DateTime? date,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: updatedTitle ?? title,
      describtion: updatedDescription ?? describtion,
      link: updatedLink ?? link,
      date: date ?? this.date,
    );
  }
}

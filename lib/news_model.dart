import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String title;
  final String description;
  final String image;
  final DateTime? timestamp;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
    this.timestamp,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json, String id) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }
}

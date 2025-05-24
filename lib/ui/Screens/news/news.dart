import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NewsPage({super.key, required this.title, required this.description, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(description, style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
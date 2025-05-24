import 'dart:io';
import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            final semester = index + 1;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.folder, color: Colors.blue, size: 40),
                title: Text(
                  'Semester $semester',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SemesterBooksPage(semester: semester),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class SemesterBooksPage extends StatelessWidget {
  final int semester;

  const SemesterBooksPage({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    final List<String> books = [
      'Book 1: Introduction to Flutter',
      'Book 2: Advanced Dart Programming',
      'Book 3: State Management Techniques',
      'Book 4: Networking in Flutter',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Semester $semester Books'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.book, color: Colors.green, size: 40),
                title: Text(
                  books[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening ${books[index]}...')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

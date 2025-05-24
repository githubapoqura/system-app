import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: 10, // Example item count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text('Assignment ${index + 1}'),
              subtitle: const Text('Due date: 2025-05-10'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Handle tap event
              },
            ),
          );
        },
      ),
    );
  }
}

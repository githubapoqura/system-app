import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Year',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildYearCard(
                      context, 'First Year', Icons.folder, Colors.red),
                  buildYearCard(
                      context, 'Second Year', Icons.folder, Colors.green),
                  buildYearCard(
                      context, 'Third Year', Icons.folder, Colors.orange),
                  buildYearCard(
                      context, 'Fourth Year', Icons.folder, Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildYearCard(
      BuildContext context, String year, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(
          year,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // Add navigation or action for each year here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening $year schedule...')),
          );
        },
      ),
    );
  }
}

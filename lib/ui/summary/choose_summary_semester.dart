import 'package:flutter/material.dart';
import 'package:untitled4/ui/summary/summary_page.dart';

class ChooseSummarySemester extends StatelessWidget {
  final String yearId;

  const ChooseSummarySemester({super.key, required this.yearId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Semester'),backgroundColor: Colors.blue,),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Semester One'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SummaryPage(yearId: yearId, semester: 1),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Semester Two'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SummaryPage(yearId: yearId, semester: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

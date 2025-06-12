import 'package:flutter/material.dart';
import 'package:untitled4/ui/Screens/schedule/schedule_page.dart';

class ChooseScheduleYear extends StatelessWidget {
  const ChooseScheduleYear({super.key});

  static const List<Map<String, String>> years = [
    {'id': 'first_year', 'name': 'first-year'},
    {'id': 'second_year', 'name': 'second-year'},
    {'id': 'third_year', 'name': 'third-year'},
    {'id': 'fourth_year', 'name': 'fourth-year'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule of years'),
        backgroundColor: Colors.blue,),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(year['name']!, style: const TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TablePage(yearId: year['id']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> semesterSummaries = [
      {
        'semester': 1,
        'courses': [
          {
            'title': ' AI',
            'summary': 'Introducation of AI.'
          },
          {
            'title': 'Data Structures',
            'summary': 'Introduction of Data Structures .'
          },
          {
            'title': 'Compiler',
            'summary': 'Introducation of compiler.'
          },
          {
            'title': 'HCI',
            'summary': 'Human Computer Interaction .'
          },
        ]
      },
      {
        'semester': 2,
        'courses': [
         {
            'title': ' AI',
            'summary': 'Introducation of AI.'
          },
          {
            'title': 'Data Structures',
            'summary': 'Introduction of Data Structures .'
          },
          {
            'title': 'Compiler',
            'summary': 'Introducation of compiler.'
          },
          {
            'title': 'HCI',
            'summary': 'Human Computer Interaction .'
          },
        ]
      },
      // Add more semesters as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester Summaries'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: semesterSummaries.length,
          itemBuilder: (context, index) {
            final semesterData = semesterSummaries[index];
            return ExpansionTile(
              title: Text(
                'Semester ${semesterData['semester']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: semesterData['courses'].map<Widget>((course) {
                return ListTile(
                  leading:
                      const Icon(Icons.book, color: Colors.orange, size: 40),
                  title: Text(
                    course['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(course['summary']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class FigmaPage extends StatelessWidget {
  const FigmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Figma Design Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Icon(
                      Icons.design_services,
                      size: 80,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Design your ideas with Figma!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Features:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.deepPurple),
                title: Text('Collaborative Design Tools'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.deepPurple),
                title: Text('Prototyping and Wireframing'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.deepPurple),
                title: Text('Cross-Platform Compatibility'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add navigation or action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

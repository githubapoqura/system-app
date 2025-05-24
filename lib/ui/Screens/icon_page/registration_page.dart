import 'package:flutter/material.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Mathematics I',
      'hours': 3,
      'instructor': 'Dr. A. Smith',
      'selected': false
    },
    {
      'title': 'Physics I',
      'hours': 4,
      'instructor': 'Dr. B. Johnson',
      'selected': false
    },
    {
      'title': 'Chemistry I',
      'hours': 3,
      'instructor': 'Dr. C. Brown',
      'selected': false
    },
    {
      'title': 'Biology I',
      'hours': 3,
      'instructor': 'Dr. D. Davis',
      'selected': false
    },
    {
      'title': 'Computer Science I',
      'hours': 3,
      'instructor': 'Dr. E. Wilson',
      'selected': false
    },
    {
      'title': 'History I',
      'hours': 2,
      'instructor': 'Dr. F. Taylor',
      'selected': false
    },
    {
      'title': 'English I',
      'hours': 2,
      'instructor': 'Dr. G. Anderson',
      'selected': false
    },
    {
      'title': 'Economics I',
      'hours': 3,
      'instructor': 'Dr. H. Thomas',
      'selected': false
    },
  ];

  final List<Map<String, dynamic>> _registeredCourses = [];
  int _totalHours = 0;

  void _registerCourses() {
    setState(() {
      _registeredCourses.clear();
      _registeredCourses.addAll(_courses.where((course) => course['selected']));
      _totalHours = _registeredCourses.fold(
          0, (int sum, course) => sum + (course['hours'] as int));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Registration'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ..._courses.map((course) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: course['selected'],
                          onChanged: (value) {
                            setState(() {
                              final int newTotalHours = _totalHours +
                                  (value!
                                      ? course['hours'] as int
                                      : -(course['hours'] as int));
                              if (newTotalHours <= 18) {
                                course['selected'] = value;
                                _totalHours = newTotalHours;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'You can only register up to 18 hours.')),
                                );
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Hours: ${course['hours']}'),
                              Text('Instructor: ${course['instructor']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerCourses,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              if (_registeredCourses.isNotEmpty) ...[
                const Text(
                  'Registered Courses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FixedColumnWidth(50),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.tealAccent),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Course Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Hours',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Instructor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ..._registeredCourses.map((course) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(course['title']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(course['hours'].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(course['instructor']),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            ],
          ),
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

import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/subject_DM.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final List<SubjectModel> _courses = [
    SubjectModel(title: 'Mathematics I', hours: 3, instructor: 'Dr. A. Smith'),
    SubjectModel(title: 'Physics I', hours: 4, instructor: 'Dr. B. Johnson'),
    SubjectModel(title: 'Chemistry I', hours: 3, instructor: 'Dr. C. Brown'),
    SubjectModel(title: 'Biology I', hours: 3, instructor: 'Dr. D. Davis'),
    SubjectModel(
        title: 'Computer Science I', hours: 3, instructor: 'Dr. E. Wilson'),
    SubjectModel(title: 'History I', hours: 2, instructor: 'Dr. F. Taylor'),
    SubjectModel(title: 'English I', hours: 2, instructor: 'Dr. G. Anderson'),
    SubjectModel(title: 'Economics I', hours: 3, instructor: 'Dr. H. Thomas'),
  ];

  List<SubjectModel> _registeredCourses = [];
  int _totalHours = 0;

  @override
  void initState() {
    super.initState();
    _loadRegisteredSubjects();
  }

  Future<void> _loadRegisteredSubjects() async {
    try {
      final service = Services();
      final registered = await service.fetchRegisteredSubjects();

      print('--- Registered subjects from Firebase ---');
      for (var r in registered) {
        print('${r.title}');
      }

      setState(() {
        _registeredCourses = registered;
        _totalHours = 0;

        for (var course in _courses) {
          final isRegistered = registered.any((r) =>
              r.title.trim().toLowerCase() ==
              course.title.trim().toLowerCase());

          course.selected = isRegistered;

          if (isRegistered) {
            _totalHours += course.hours;
          }
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading registered subjects: $e')),
      );
    }
  }

  void _registerCourses() async {
    setState(() {
      _registeredCourses = _courses.where((course) => course.selected).toList();
      _totalHours =
          _registeredCourses.fold(0, (sum, course) => sum + course.hours);
    });

    try {
      final service = Services();
      await service.clearCourses();
      await service.registerCourses(_registeredCourses);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Courses registered successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _toggleCourseSelection(bool? value, int index) {
    final course = _courses[index];
    final int hoursChange = value! ? course.hours : -course.hours;
    final int newTotalHours = _totalHours + hoursChange;

    if (newTotalHours <= 18) {
      setState(() {
        course.selected = value;
        _totalHours = newTotalHours;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only register up to 18 hours.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Registration'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Courses',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 20),
            ..._courses.asMap().entries.map((entry) {
              final index = entry.key;
              final course = entry.value;
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: course.selected,
                        onChanged: (value) =>
                            _toggleCourseSelection(value, index),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(course.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Hours: ${course.hours}'),
                            Text('Instructor: ${course.instructor}'),
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
              child: const Text('Register', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            if (_registeredCourses.isNotEmpty) ...[
              const Text(
                'Registered Courses',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
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
                        child: Text('Course Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hours',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Instructor',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  ..._registeredCourses.map((course) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course.title),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course.hours.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(course.instructor),
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
    );
  }
}

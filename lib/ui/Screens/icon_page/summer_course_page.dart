import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/subject_DM.dart';

class SummerCoursePage extends StatefulWidget {
  const SummerCoursePage({super.key});

  @override
  _SummerCoursePageState createState() => _SummerCoursePageState();
}

class _SummerCoursePageState extends State<SummerCoursePage> {
  final List<SubjectModel> _courses = [
    SubjectModel(
      title: 'Introduction to Programming',
      hours: 3,
      instructor: 'Dr. John Doe',
      selected: false,
    ),
    SubjectModel(
      title: 'Graphic Design Basics',
      hours: 2,
      instructor: 'Dr. Jane Smith',
      selected: false,
    ),
    SubjectModel(
      title: 'Data Science 101',
      hours: 4,
      instructor: 'Dr. Emily Davis',
      selected: false,
    ),
  ];

  final List<SubjectModel> _enrolledCourses = [];

  void _enrollCourses() async {
    setState(() {
      _enrolledCourses.clear();
      _enrolledCourses.addAll(_courses.where((course) => course.selected));
    });

    final int totalHours =
        _enrolledCourses.fold(0, (int sum, course) => sum + course.hours);
    if (totalHours > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only register up to 6 hours.')),
      );
      _enrolledCourses.clear();
      return;
    }

    await Services().clearSummerCourses();
    await Services().registerSummerCourses(_enrolledCourses);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Courses enrolled successfully!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadEnrolledCourses();
  }

  Future<void> _loadEnrolledCourses() async {
    final fetchedCourses = await Services().fetchRegisteredSummerSubjects();
    setState(() {
      _enrolledCourses.clear();
      _enrolledCourses.addAll(fetchedCourses);

      for (var course in _courses) {
        course.selected = fetchedCourses.any(
          (c) =>
              c.title.trim().toLowerCase() ==
                  course.title.trim().toLowerCase() &&
              c.instructor.trim().toLowerCase() ==
                  course.instructor.trim().toLowerCase() &&
              c.hours == course.hours,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summer Courses'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Summer Courses',
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
                          value: course.selected,
                          onChanged: (value) {
                            setState(() {
                              final int newTotalHours = _courses.fold(
                                      0,
                                      (int sum, course) =>
                                          sum +
                                          (course.selected
                                              ? course.hours
                                              : 0)) +
                                  (value! ? course.hours : -course.hours);
                              if (newTotalHours <= 6) {
                                course.selected = value;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'You can only register up to 6 hours.')),
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
                                course.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Instructor: ${course.instructor}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
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
                onPressed: _enrollCourses,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  'Enroll',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              if (_enrolledCourses.isNotEmpty) ...[
                const Text(
                  'Enrolled Courses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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
                      decoration: BoxDecoration(color: Colors.blueAccent),
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
                    ..._enrolledCourses.map((course) {
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
      ),
    );
  }
}

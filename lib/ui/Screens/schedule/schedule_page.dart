import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/ui/Screens/schedule/schedule_dm.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key, required this.yearId});
  final String yearId;

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final Services _repo = Services();
  Future<List<ScheduleDm>>? scheduleFuture;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Schedule Viewer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => handleYearTap(context),
                child: const Text('عرض الجدول'),
              ),
              const SizedBox(height: 20),
              if (scheduleFuture != null)
                Expanded(
                  child: FutureBuilder<List<ScheduleDm>>(
                    future: scheduleFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('خطأ: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('لا يوجد جدول متاح'));
                      }

                      final schedules = snapshot.data!;
                          return  ListView.separated(
                            itemCount: schedules.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final schedule = schedules[index];
                              print('📷 Image URL: ${schedule.image}');

                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // علشان العنوان يبدأ من اليسار
                                    children: [
                                      Center(
                                        child: Text(
                                          schedule.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          schedule.image.isNotEmpty
                                              ? schedule.image
                                              : 'https://via.placeholder.com/150', // صورة افتراضية لو فاضية
                                          width: double.infinity,
                                          height: 180,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image, size: 60),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                        },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void loadSchedule({String? departmentId}) {
    scheduleFuture = _repo.getSchedule(
      yearId: widget.yearId,
      departmentId: departmentId,
    );
    setState(() {});
  }

  Future<List<String>> getDepartments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('schedule_sections')
        .doc(widget.yearId)
        .collection('departments')
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  void handleYearTap(BuildContext context) async {
    if (widget.yearId == 'third_year' || widget.yearId == 'fourth_year') {
      final departments = await getDepartments();

      if (departments.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا توجد أقسام متاحة')),
        );
        return;
      }

      String? selectedDept;

      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('اختر القسم'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return DropdownButton<String>(
                  value: selectedDept,
                  isExpanded: true,
                  hint: const Text('اختر القسم'),
                  onChanged: (value) {
                    setState(() => selectedDept = value);
                  },
                  items: departments.map((dept) {
                    return DropdownMenuItem(
                      value: dept,
                      child: Text(dept),
                    );
                  }).toList(),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (selectedDept != null) {
                    Navigator.pop(context);
                    loadSchedule(departmentId: selectedDept);
                  }
                },
                child: const Text('تم'),
              )
            ],
          );
        },
      );
    } else {
      loadSchedule();
    }
  }
}

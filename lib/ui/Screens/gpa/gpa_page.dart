import 'package:flutter/material.dart';
import 'gpa_model.dart';  // تأكد أن مسار الاستيراد صحيح
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GpaPage extends StatelessWidget {
  const GpaPage({super.key});

  Future<GpaModel> fetchGpaData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) throw Exception("No GPA data found");

    return GpaModel.fromMap(doc.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My grade"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<GpaModel>(
        future: fetchGpaData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final gpaData = snapshot.data!;
          final results = gpaData.results;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // بطاقة GPA
                Card(
                  color: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          "Your Overall GPA",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          gpaData.gpa.toStringAsFixed(2),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Cumulative Grade Point Average",
                          style:
                          TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // عنوان النتائج
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Result",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                // الجدول
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FixedColumnWidth(30),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FixedColumnWidth(50),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.grey),
                      children: [
                        tableCell("No", isHeader: true),
                        tableCell("Subject", isHeader: true),
                        tableCell("Semester", isHeader: true),
                        tableCell("Score", isHeader: true),
                      ],
                    ),
                    for (int i = 0; i < results.length; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: i.isEven ? Colors.red.shade50 : null,
                        ),
                        children: [
                          tableCell((i + 1).toString()),
                          tableCell(results[i].subject),
                          tableCell(results[i].semester),
                          tableCell(results[i].score),
                        ],
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // ملاحظات مهمة
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "IMPORTANT NOTES:",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "• You are required to fill out all Lecturing Evaluations before you can view your GPA.\n"
                      "• Please check the Outstanding Payment column below. If you have Outstanding Payment, you won’t be able to view both of Semester GPA and Cumulative GPA.\n"
                      "• If you think this shouldn’t be happen, please contact Finance Dept.",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}

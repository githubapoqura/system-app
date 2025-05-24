import 'package:flutter/material.dart';

class GpaPage extends StatelessWidget {
  const GpaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My grade"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // GPA Card
            Card(
              color: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: const [
                    Text("Your Overall GPA",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 10),
                    Text("3.5",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Cumulative Grade Point Average",
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Result table title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Result",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),

            // Table
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
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    tableCell("No", isHeader: true),
                    tableCell("Subject", isHeader: true),
                    tableCell("Semester", isHeader: true),
                    tableCell("Score", isHeader: true),
                  ],
                ),
                for (int i = 1; i <= 8; i++)
                  TableRow(
                    decoration: BoxDecoration(
                        color: i.isEven ? Colors.red.shade50 : null),
                    children: [
                      tableCell(i.toString()),
                      tableCell("Subject"),
                      tableCell("20201"),
                      tableCell(i < 3 ? "A" : "B"),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Important Notes
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "IMPORTANT NOTES:",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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

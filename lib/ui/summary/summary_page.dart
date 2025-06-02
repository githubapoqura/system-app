import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/ui/summary/summary_dm.dart';
import 'package:url_launcher/url_launcher.dart';

class SummaryPage extends StatefulWidget {
  final int semester;
  final String yearId;

  const SummaryPage({
    super.key,
    required this.semester,
    required this.yearId,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final Services _repo = Services();
  late Future<List<SummaryModel>> summariesFuture;

  @override
  void initState() {
    super.initState();
    summariesFuture = _repo.getSummeryForSemester(
      yearId: widget.yearId,
      semesterId: 'semester${widget.semester}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester ${widget.semester}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<SummaryModel>>(
          future: summariesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'حدث خطأ أثناء تحميل الملخصات.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد ملخصات متاحة لهذا السميستر.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            final summaries = snapshot.data!;
            return ListView.separated(
              itemCount: summaries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final summary = summaries[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: const Icon(Icons.notes, color: Colors.orange, size: 40),
                    title: Text(
                      summary.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      final Uri url = Uri.parse(summary.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تعذر فتح الرابط')),
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

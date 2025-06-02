import 'package:flutter/material.dart';
import 'package:untitled4/firebase.dart';
import 'package:untitled4/ui/Screens/book_Dm.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksPage extends StatefulWidget {
  final int semester;
  final String yearId;

  const BooksPage({
    super.key,
    required this.semester,
    required this.yearId,
  });

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final Services _repo = Services();
  late Future<List<BookModel>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = _repo.getBooksForSemester(
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
        child: FutureBuilder<List<BookModel>>(
          future: booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'حدث خطأ أثناء تحميل الكتب.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد كتب متاحة لهذا السميستر.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            final books = snapshot.data!;
            return ListView.separated(
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading:
                        const Icon(Icons.book, color: Colors.indigo, size: 40),
                    title: Text(
                      book.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.download),
                    onTap: () async {
                      final Uri url = Uri.parse(book.url);
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

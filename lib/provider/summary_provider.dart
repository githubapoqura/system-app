import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/ui/Screens/book_Dm.dart';

class SummaryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<BookModel> _books = [];

  List<BookModel> get books => _books;

  Future<void> loadSummary({
    required String yearId,
    required String semesterId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('summary_sections')
          .doc(yearId)
          .collection('semesters')
          .doc(semesterId)
          .collection('books')
          .get();

      _books =
          snapshot.docs.map((doc) => BookModel.fromMap(doc.data())).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading books: $e');
      _books = [];
      notifyListeners();
    }
  }
}

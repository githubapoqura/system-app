class SubjectResult {
  final String subject;
  final String semester;
  final String score;

  SubjectResult({
    required this.subject,
    required this.semester,
    required this.score,
  });

  factory SubjectResult.fromMap(Map<String, dynamic> map) {
    return SubjectResult(
      subject: map['subject'] ?? '',
      semester: map['semester'] ?? '',
      score: map['score'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'semester': semester,
      'score': score,
    };
  }
}

class GpaModel {
  final double gpa;
  final List<SubjectResult> results;

  GpaModel({
    required this.gpa,
    required this.results,
  });

  factory GpaModel.fromMap(Map<String, dynamic> map) {
    final gpaValue = double.tryParse(map['gpa']?.toString() ?? '0.0') ?? 0.0;

    final rawResults = map['results'];
    List<SubjectResult> resultsList = [];


    if (rawResults is List) {
      resultsList = rawResults
          .whereType<Map<String, dynamic>>()
          .map((e) => SubjectResult.fromMap(e))
          .toList();
    }


    return GpaModel(
      gpa: gpaValue,
      results: resultsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gpa': gpa,
      'results': results.map((e) => e.toMap()).toList(),
    };
  }
}
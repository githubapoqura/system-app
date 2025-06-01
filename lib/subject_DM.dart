class SubjectModel {
  final String title;
  final int hours;
  final String instructor;
  bool selected;

  SubjectModel({
    required this.title,
    required this.hours,
    required this.instructor,
    this.selected = false,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        title: json['title'],
        hours: json['hours'],
        instructor: json['instructor'],
        selected: json['selected'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'hours': hours,
        'instructor': instructor,
        'selected': selected,
      };
}

class SummaryModel {
  final String name;
  final String url;

  SummaryModel({required this.name, required this.url});

  factory SummaryModel.fromMap(Map<String, dynamic> map) {
    return SummaryModel(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }
}

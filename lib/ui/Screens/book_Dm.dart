class BookModel {
  final String name;
  final String url;

  BookModel({required this.name, required this.url});

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      name: map['name']?.toString() ?? '',
      url: map['url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }
}

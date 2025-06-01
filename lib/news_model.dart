class NewsModel {
  final String title;
  final String description;
  final String image;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json, String id) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }
}

import 'dart:convert';

class Article {
  String title;
  final String imageUrl;
  String description;
  final String url;

  Article({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.url,
  }) {
    description = description.trim();
    title = title.trim();
  }
}

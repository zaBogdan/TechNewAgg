import 'package:flutter/material.dart';
import 'package:technewsagg/models/article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  set articles(List<Article> articles) {
    _articles = articles;
    notifyListeners();
  }
}

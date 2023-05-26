import 'package:flutter/material.dart';
import 'package:technewsagg/models/article.dart';

class ArticleProvider extends ChangeNotifier {
  Article? _article;
  Article? get current => _article;
}

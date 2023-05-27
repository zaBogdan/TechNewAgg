import 'package:flutter/material.dart';
import 'package:technewsagg/api/client.dart';
import 'package:technewsagg/models/article.dart';
import 'package:technewsagg/models/user.dart';
import 'package:technewsagg/providers/user.dart';

class ArticleProvider extends ChangeNotifier {
  Future<List<ResponseType>> getArticlesForUserFeeds(User currentUser) async {
    List<String> feedNames = currentUser.websites.toList();
    return await RSSClient.getArticlesForUserFeeds(feedNames);
  }
}

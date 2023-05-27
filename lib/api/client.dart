import 'package:http/http.dart';
import 'package:xml/xml.dart' as xml;
import 'package:logging/logging.dart';
import 'package:technewsagg/api/rss_feeds.dart';
import 'package:technewsagg/models/article.dart';

class ResponseType {
  final String name;
  final List<Article> articles;

  ResponseType(this.name, this.articles);
}

class RSSClient {
  static Future<List<ResponseType>> getArticlesForUserFeeds(
      List<String> feedNames) async {
    List<ResponseType> responseTypes = [];
    for (var feedName in feedNames) {
      responseTypes.add(
          ResponseType(feedName, await getTop10ArticlesFromFeed(feedName)));
    }

    return responseTypes;
  }

  static Future<List<Article>> getTop10ArticlesFromFeed(String feedName) async {
    try {
      final feed = RSSFeeds().feedForName(feedName);
      final response = await get(Uri.parse(feed.url));
      if (response.statusCode != 200) {
        Logger.root.warning(
            "Failed to get data from $feedName. Failed with ${response.statusCode} status code");
        return [];
      }
      final items = xml.XmlDocument.parse(response.body)
          .findAllElements('item')
          .toList()
          .sublist(0, 10);

      List<Article> articles = [];
      for (var item in items) {
        String title =
            item.findElements(feed.fieldsLocation.title).single.text.trim();
        String description =
            item.findElements(feed.fieldsLocation.description).single.text;
        String url = item.findElements(feed.fieldsLocation.url).single.text;
        String imageUrl = item
            .findElements(feed.fieldsLocation.imageUrl)
            .first
            .getAttribute('url')
            .toString();
        articles.add(Article(
            title: title,
            imageUrl: imageUrl,
            description: description,
            url: url));
      }
      return articles;
    } catch (e) {
      Logger.root.severe("Failed to get data from feed. $e");
    }
    return [];
  }
}

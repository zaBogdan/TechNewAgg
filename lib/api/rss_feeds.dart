import 'package:technewsagg/models/feed.dart';

class RSSFeeds {
  List<Feed> feeds = [
    Feed(
      name: 'Fox Sports Digital',
      url:
          'https://api.foxsports.com/v2/content/optimized-rss?partnerKey=MB0Wehpmuj2lUhuRhQaafhBjAJqaPU244mlTDK1i&size=30',
      fieldsLocation: FieldsLocation(imageUrl: 'media:content'),
    ),
    Feed(
      name: 'Entrepreneur: Latest Marketing Articles',
      url: 'https://www.entrepreneur.com/topic/marketing.rss',
      fieldsLocation: FieldsLocation(imageUrl: 'media:content'),
    ),
    Feed(
        name: 'The Hacker News',
        url: 'https://feeds.feedburner.com/TheHackersNews',
        fieldsLocation: FieldsLocation(imageUrl: 'enclosure')),
    Feed(
        name: 'VICE US',
        url: 'https://www.vice.com/en/rss?locale=en_us',
        fieldsLocation: FieldsLocation(imageUrl: 'enclosure')),
    Feed(
        name: 'The Next Web',
        url: 'http://feeds2.feedburner.com/TheNextWeb',
        fieldsLocation: FieldsLocation(imageUrl: 'enclosure')),
    Feed(
        name: 'NASA Breaking News',
        url: 'https://www.nasa.gov/rss/dyn/breaking_news.rss',
        fieldsLocation: FieldsLocation(imageUrl: 'enclosure')),
    Feed(
        name: 'New york times',
        url: 'https://rss.nytimes.com/services/xml/rss/nyt/World.xml',
        fieldsLocation: FieldsLocation(imageUrl: 'media:content')),
    Feed(
        name: 'Political news on Fox News',
        url: 'https://moxie.foxnews.com/google-publisher/politics.xml',
        fieldsLocation: FieldsLocation(imageUrl: 'media:content', url: 'guid')),
    Feed(
        name: 'Smashing Magazine',
        url: 'https://www.smashingmagazine.com/feed/',
        fieldsLocation: FieldsLocation(imageUrl: 'enclosure', url: 'guid'))
  ];

  List<String> get feedNames => feeds.map((feed) => feed.name).toList();
  Feed feedForName(String feedName) =>
      feeds.firstWhere((feed) => feed.name == feedName, orElse: () => feeds[0]);
}

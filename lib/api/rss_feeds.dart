import 'package:technewsagg/models/feed.dart';

class RSSFeeds {
  List<Feed> feeds = [
    Feed(
        name: 'Fox Sports Digital',
        url:
            'https://api.foxsports.com/v2/content/optimized-rss?partnerKey=MB0Wehpmuj2lUhuRhQaafhBjAJqaPU244mlTDK1i&size=30'),
    Feed(
        name: 'Entrepreneur: Latest Marketing Articles',
        url: 'https://www.entrepreneur.com/topic/marketing.rss'),
    Feed(
        name: 'Content Marketing Institute',
        url: 'http://contentmarketinginstitute.com/feed/'),
    Feed(name: 'The Keyword', url: 'https://www.blog.google/rss/'),
    Feed(
        name: 'Microsoft Power BI Blog | Microsoft Power BI',
        url: 'https://powerbi.microsoft.com/en-us/blog/feed/'),
    Feed(
        name:
            'Search Engine Land: News & Info About SEO, PPC, SEM, Search Engines & Search Marketing',
        url: 'http://feeds.searchengineland.com/searchengineland'),
    Feed(
        name: 'MacRumors: Mac News and Rumors - All Stories',
        url: 'http://feeds.macrumors.com/MacRumors-All'),
    Feed(name: '9to5Mac', url: 'https://9to5mac.com/feed/'),
    Feed(
        name: 'Latest Security Advisories',
        url: 'https://technet.microsoft.com/en-us/security/rss/advisory'),
    Feed(name: 'Dark Reading', url: 'https://www.darkreading.com/rss.xml'),
    Feed(
        name: 'The Hacker News',
        url: 'http://feeds.feedburner.com/TheHackersNews'),
    Feed(
        name: 'US-CERT Current Activity',
        url: 'https://www.us-cert.gov/ncas/current-activity.xml'),
  ];

  List<String> get feedNames => feeds.map((feed) => feed.name).toList();
}

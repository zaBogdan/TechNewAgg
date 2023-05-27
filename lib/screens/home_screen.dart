import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technewsagg/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _newsPerCategory(String category, List<Article> articles) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          category,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 350.0,
        child: ListView.builder(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 2,
                  color: Colors.grey[30],
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Image.network(
                            articles[index].imageUrl,
                            width: 256,
                            height: 128,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          width: 256,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  articles[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Container(height: 10),
                                Text(
                                  articles[index].description,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.transparent,
                                      ),
                                      child: const Text(
                                        "SHARE",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                      onPressed: () {
                                        Share.share(
                                            'Check out this article from Tech News Aggregator: ${articles[index].url.toString()}');
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.transparent,
                                      ),
                                      child: const Text(
                                        "READ MORE",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () async {
                                        final Uri uri = Uri.parse(
                                            articles[index].url.toString());
                                        if (!await launchUrl(uri)) {
                                          Logger.root.info(
                                              "Failed to launch url: ${articles[index].url.toString()}");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Could not launch url'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ]),
                ));
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Implement your main app interface here
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tech News App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(children: [
        _newsPerCategory('Recommended for your', <Article>[
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
          Article(
              title:
                  'Jimmy Uso calls himself The Tribal Chief before brawling with Sami Zayn, KO and The Bloodline',
              imageUrl:
                  'https://static-media.fox.com/ms/stg1/sports/play-66adddc94000c21--Bloodline_KO_Samii_mp4_00_06_38_07_Still002_1685161535779.jpg',
              description:
                  'Jimmy Uso shocked the WWE Universe and The Bloodline alike when he called himself The Tribal Chief while in a war of words with The Undisputed Tag Team Champions Sami Zayn and Kevin Owens on Friday Night SmackDown.',
              url: 'https://www.foxsports.com/watch/play-66adddc94000c21'),
        ]),
      ]),
    );
  }
}

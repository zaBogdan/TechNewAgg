import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technewsagg/models/article.dart';
import 'package:technewsagg/providers/article.dart';
import 'package:technewsagg/providers/user.dart';
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
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 10),
                                Text(
                                  articles[index].description,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 12,
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
            'All your feeds',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: FutureBuilder(
          future: context.read<ArticleProvider>().getArticlesForUserFeeds(
              context.read<UserProvider>().currentUser!),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView(
                children: snapshot.data!
                    .map((e) => _newsPerCategory(e.name, e.articles))
                    .toList(),
              ),
            );
          },
        ));
  }
}

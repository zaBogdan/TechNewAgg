import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:technewsagg/models/settings.dart';
import 'package:technewsagg/models/store.dart';
import 'package:technewsagg/providers/article.dart';
import 'package:technewsagg/providers/subscriptions.dart';
import 'package:technewsagg/providers/user.dart';

import 'package:technewsagg/screens/home_screen.dart';
import 'package:technewsagg/screens/select_user_screen.dart';
import 'package:technewsagg/screens/welcome_screen.dart';

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  Logger.root.info('Initializing app');
  if ((await Store.get('settings')).isEmpty) {
    await Store.set('settings', Settings.getDefaultSettings().toJson());
  }
}

Future<void> main() async {
  await initApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SubscriptionsProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ArticleProvider()),
    ],
    child: TechNewsAgg(),
  ));
}

class TechNewsAgg extends StatelessWidget {
  TechNewsAgg({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechNewsAgg',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomeScreen(),
    );
  }
}

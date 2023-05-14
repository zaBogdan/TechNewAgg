import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technewsagg/screens/home_screen.dart';
import 'package:technewsagg/screens/welcome_screen.dart';
import 'package:logging/logging.dart';

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

void main() {
  initLogger();
  runApp(TechNewsAgg());
}

class TechNewsAgg extends StatelessWidget {
  TechNewsAgg({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechNewsAgg',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen()
      },
    );
  }
}

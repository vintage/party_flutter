import 'package:flutter/material.dart';
import 'package:zgadula/services/tutorial.dart';
import 'screens/tutorial.dart';
import 'screens/home.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isTutorialWatched = false;

  @override
  void initState() {
    super.initState();
    this.initTutorial();
  }

  initTutorial() async {
    final bool isTutorialWatched = await TutorialService.isWatched();

    setState(() {
      this.isTutorialWatched = isTutorialWatched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zgadula',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
      ),
      home: this.isTutorialWatched ? HomeScreen() : TutorialScreen(),
    );
  }
}

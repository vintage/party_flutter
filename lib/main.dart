import 'package:flutter/material.dart';
import 'screens/tutorial.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zgadula',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TutorialScreen(),
    );
  }
}

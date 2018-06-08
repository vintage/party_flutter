import 'package:flutter/material.dart';

class CategoryPlayScreen extends StatefulWidget {
  CategoryPlayScreen({Key key}) : super(key: key);

  @override
  CategoryPlayScreenStage createState() => new CategoryPlayScreenStage();
}

class CategoryPlayScreenStage extends State<CategoryPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Play the game"),
        new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ],
    )));
  }
}

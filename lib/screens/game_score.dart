import 'package:flutter/material.dart';

import 'package:zgadula/models/question.dart';

class GameScoreScreen extends StatefulWidget {
  GameScoreScreen({Key key, this.questionsValid, this.questionsInvalid})
      : super(key: key);

  final List<Question> questionsValid;
  final List<Question> questionsInvalid;

  @override
  GameScoreScreenStage createState() => new GameScoreScreenStage();
}

class GameScoreScreenStage extends State<GameScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text('Correct'),
        new Column(
          children: new List.generate(widget.questionsValid.length,
              (index) => new Text(widget.questionsValid[index].name)).toList(),
        ),
        new Text('Incorrect'),
        new Column(
          children: new List.generate(widget.questionsInvalid.length,
                  (index) => new Text(widget.questionsInvalid[index].name)).toList(),
        ),
      ],
    )));
  }
}

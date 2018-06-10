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
  goBack() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questionsValid = widget.questionsValid;
    List<Question> questionsInvalid = widget.questionsInvalid;

    return new Scaffold(
        body: new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Text(
            '${questionsValid.length} / ${(questionsValid.length + questionsInvalid.length)}'),
        new Expanded(
            child: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Text('Correct'),
                new Column(
                  children: new List.generate(questionsValid.length,
                          (index) => new Text(questionsValid[index].name)).toList(),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                new Text('Incorrect'),
                new Column(
                  children: new List.generate(questionsInvalid.length,
                          (index) => new Text(questionsInvalid[index].name)).toList(),
                ),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )),
        new RaisedButton(child: const Text("Back"), onPressed: goBack),
      ],
    ));
  }
}

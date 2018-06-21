import 'package:flutter/material.dart';

import 'package:zgadula/models/question.dart';

class GameScoreScreen extends StatefulWidget {
  GameScoreScreen({Key key, this.questionsValid, this.questionsInvalid})
      : super(key: key);

  final List<Question> questionsValid;
  final List<Question> questionsInvalid;

  @override
  GameScoreScreenStage createState() => GameScoreScreenStage();
}

class GameScoreScreenStage extends State<GameScoreScreen> {
  goBack() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questionsValid = widget.questionsValid;
    List<Question> questionsInvalid = widget.questionsInvalid;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${questionsValid.length} / ${(questionsValid.length + questionsInvalid.length)}',
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Correct'),
                      Column(
                        children: List
                            .generate(
                              questionsValid.length,
                              (index) => Text(questionsValid[index].name),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Incorrect'),
                      Column(
                        children: List
                            .generate(
                              questionsInvalid.length,
                              (index) => Text(questionsInvalid[index].name),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
            RaisedButton(child: const Text("Back"), onPressed: goBack),
          ],
        ),
      ),
    );
  }
}

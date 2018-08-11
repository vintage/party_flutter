import 'package:flutter/material.dart';

import 'package:zgadula/models/question.dart';

class GameScoreScreen extends StatefulWidget {
  GameScoreScreen({Key key, this.questionsValid, this.questionsInvalid})
      : super(key: key);

  final List<Question> questionsValid;
  final List<Question> questionsInvalid;

  @override
  GameScoreScreenState createState() => GameScoreScreenState();
}

class GameScoreScreenState extends State<GameScoreScreen> {
  goBack() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  List<Widget> buildQuestionsList(List<Question> questions) {
    return List
        .generate(
          questions.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(questions[index].name),
          ),
        )
        .toList();
  }

  Widget buildIcon(IconData icon, MaterialColor color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0),
      child: Icon(icon, color: color, size: 48.0),
    );
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
                      buildIcon(Icons.check, Colors.green),
                      Column(
                        children: buildQuestionsList(questionsValid),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      buildIcon(Icons.close, Colors.red),
                      Column(
                        children: buildQuestionsList(questionsInvalid),
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

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/screens/game_score.dart';

class CategoryPlayScreen extends StatefulWidget {
  CategoryPlayScreen({Key key, this.questions}) : super(key: key);

  final List<Question> questions;

  @override
  CategoryPlayScreenStage createState() => new CategoryPlayScreenStage();
}

class CategoryPlayScreenStage extends State<CategoryPlayScreen> {
  Timer gameTimer;
  static const secondsMax = 30;
  int secondsLeft = 30;
  int level = 0;

  List<Question> questionsValid = [];
  List<Question> questionsInvalid = [];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();

    stopTimer();
  }

  stopTimer() {
    if (gameTimer != null && gameTimer.isActive) {
      gameTimer.cancel();
    }
  }

  startTimer() {
    gameTimer = new Timer.periodic(const Duration(seconds: 1), gameLoop);
  }

  gameLoop(Timer timer) {
    if (secondsLeft == 0) {
      _handleTimeout();
      return;
    }

    setState(() {
      secondsLeft -= 1;
    });
  }

  String getTimeLeft() {
    int minutes = (secondsLeft / 60).floor();
    int seconds = secondsLeft % 60;

    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  Question getCurrentQuestion() {
    return widget.questions[level];
  }

  showScore() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GameScoreScreen(
                  questionsValid: questionsValid,
                  questionsInvalid: questionsInvalid,
                )));
  }

  goBack() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        return new AlertDialog(
          content: new Text('Do you want to cancel current game?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Yes'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _nextQuestion() {
    stopTimer();

    if (level + 1 == 10) {
      showScore();

      return;
    }

    setState(() {
      secondsLeft = secondsMax;
      level += 1;
    });

    startTimer();
  }

  _handleValid() {
    questionsValid.add(getCurrentQuestion());

    _nextQuestion();
  }

  _handleInvalid() {
    questionsInvalid.add(getCurrentQuestion());

    _nextQuestion();
  }

  _handleTimeout() {
    _handleInvalid();
  }

  @override
  Widget build(BuildContext context) {
    String timeLeft = getTimeLeft();
    String currentQuestion = getCurrentQuestion().name;

    return new Scaffold(
        floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.arrow_back),
          backgroundColor: new Color(0xFFE57373),
          onPressed: goBack,
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Text(currentQuestion),
              ),
            ),
            new Row(
              children: <Widget>[
                new RaisedButton(
                    color: Colors.green,
                    onPressed: _handleValid,
                    child: new Text('Yes')),
                new RaisedButton(
                    color: Colors.red,
                    onPressed: _handleInvalid,
                    child: new Text('No')),
              ],
            ),
            new Text(timeLeft),
          ],
        ));
  }
}

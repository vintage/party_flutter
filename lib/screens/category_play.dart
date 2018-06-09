import 'dart:async';
import 'package:flutter/material.dart';

import 'package:zgadula/models/question.dart';

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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @protected
  @mustCallSuper
  void dispose () {
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

  _nextQuestion() {
    stopTimer();

    setState(() {
      secondsLeft = secondsMax;
      level += 1;
    });

    startTimer();
  }

  _handleValid() {
    _nextQuestion();
  }

  _handleInvalid() {
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    String timeLeft = getTimeLeft();
    String currentQuestion = widget.questions[level].name;

    return new Scaffold(
        body: new Center(
            child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(currentQuestion),
        new Text(timeLeft),
        new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        new Row(
          children: <Widget>[
            new RaisedButton(color: Colors.green, onPressed: _handleValid, child: new Text('Yes')),
            new RaisedButton(color: Colors.red, onPressed: _handleInvalid, child: new Text('No')),
          ],
        )
      ],
    )));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/screens/game_score.dart';

class CategoryPlayScreen extends StatefulWidget {
  CategoryPlayScreen({Key key, this.questions}) : super(key: key);

  final List<Question> questions;

  @override
  CategoryPlayScreenStage createState() => CategoryPlayScreenStage();
}

class CategoryPlayScreenStage extends State<CategoryPlayScreen> {
  Timer gameTimer;
  static const secondsMax = 30;
  int secondsLeft = 3;
  int level = 0;
  bool isStarted = false;

  List<Question> questionsValid = [];
  List<Question> questionsInvalid = [];

  @override
  void initState() {
    super.initState();
    startTimer();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @protected
  @mustCallSuper
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
    stopTimer();
  }

  stopTimer() {
    if (gameTimer != null && gameTimer.isActive) {
      gameTimer.cancel();
    }
  }

  startTimer() {
    gameTimer = Timer.periodic(const Duration(seconds: 1), gameLoop);
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScoreScreen(
              questionsValid: questionsValid,
              questionsInvalid: questionsInvalid,
            ),
      ),
    );
  }

  Future<bool> confirmBack() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Do you want to cancel current game?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
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
    if (isStarted) {
      _handleInvalid();
    } else {
      setState(() {
        isStarted = true;
        secondsLeft = secondsMax;
      });
    }
  }

  Widget buildHeader(text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget buildCountdownContent() {
    String timeLeft = getTimeLeft();

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: buildHeader(timeLeft),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameContent() {
    String timeLeft = getTimeLeft();
    String currentQuestion = getCurrentQuestion().name;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: buildHeader(currentQuestion),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              timeLeft,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                onPressed: _handleValid,
                child: Text('Yes'),
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: _handleInvalid,
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await confirmBack();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.arrow_back),
          backgroundColor: Color(0xFFE57373),
          onPressed: () async {
            if (await confirmBack()) {
              Navigator.of(context).pop();
            }
          },
        ),
        body: isStarted ? buildGameContent() : buildCountdownContent(),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zgadula/localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/screens/game_score.dart';

class CategoryPlayScreen extends StatefulWidget {
  CategoryPlayScreen({Key key}) : super(key: key);

  @override
  CategoryPlayScreenState createState() => CategoryPlayScreenState();
}

class CategoryPlayScreenState extends State<CategoryPlayScreen> {
  Timer gameTimer;
  static const secondsMax = 5;
  int secondsLeft = 3;
  bool isStarted = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startTimer();

    QuestionModel
        .of(context)
        .generateCurrentQuestions(CategoryModel.of(context).currentCategory.id);

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
      handleTimeout();
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

  showScore() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScoreScreen(),
      ),
    );
  }

  Future<bool> confirmBack() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context).gameCancelConfirmation),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).gameCancelApprove),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).gameCancelDeny),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  nextQuestion() {
    stopTimer();

    QuestionModel.of(context).setNextQuestion();
    if (QuestionModel.of(context).currentQuestion == null) {
      showScore();

      return;
    }

    setState(() {
      isPaused = false;
      secondsLeft = secondsMax;
    });

    startTimer();
  }

  handleValid() {
    QuestionModel.of(context).markQuestionAsValid();

    setState(() {
      isPaused = true;
      secondsLeft = 1;
    });
  }

  handleInvalid() {
    QuestionModel.of(context).markQuestionAsInvalid();

    setState(() {
      isPaused = true;
      secondsLeft = 1;
    });
  }

  handleTimeout() {
    if (isPaused) {
      nextQuestion();
    } else if (isStarted) {
      handleInvalid();
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
      ),
    );
  }

  Widget buildSplashContent(String text, Color background) {
    return Container(
      decoration: BoxDecoration(color: background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: buildHeader(text),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameContent() {
    String timeLeft = getTimeLeft();

    return ScopedModelDescendant<QuestionModel>(
      builder: (context, child, model) {
        return GestureDetector(
          onTap: handleValid,
          onDoubleTap: handleInvalid,
          behavior: HitTestBehavior.opaque,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: buildHeader(model.currentQuestion.name),
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildContent() {
    if (isPaused) {
      return buildSplashContent(
        AppLocalizations.of(context).nextQuestion,
        QuestionModel.of(context).currentQuestion.isPassed
            ? Theme.of(context).accentColor
            : Theme.of(context).errorColor
      );
    } else if (isStarted) {
      return buildGameContent();
    }

    return buildSplashContent(getTimeLeft(), Colors.transparent);
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
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            if (await confirmBack()) {
              Navigator.of(context).pop();
            }
          },
        ),
        body: buildContent(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zgadula/localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/components/bottom_button.dart';

class GameScoreScreen extends StatelessWidget {
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
    return ScopedModelDescendant<QuestionModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '${model.questionsPassed.length} / ${model.currentQuestions.length}',
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          buildIcon(Icons.check, Colors.green),
                          Column(
                            children: buildQuestionsList(model.questionsPassed),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          buildIcon(Icons.close, Colors.red),
                          Column(
                            children: buildQuestionsList(model.questionsFailed),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
                BottomButton(
                  child: Text(AppLocalizations.of(context).summaryBack),
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName('/')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

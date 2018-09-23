import 'package:flutter/material.dart';
import 'package:zgadula/localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/components/bottom_button.dart';

class GameScoreScreen extends StatelessWidget {
  Widget buildQuestionItem(BuildContext context, Question question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            question.isPassed ? Icons.check : Icons.close,
            size: 16.0,
            color: question.isPassed ? Theme.of(context).accentColor : Theme.of(context).errorColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              question.name,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildQuestionsList(
    BuildContext context,
    List<Question> questions,
  ) {
    return List.generate(
      questions.length,
      (index) => buildQuestionItem(context, questions[index]),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<QuestionModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).summaryHeader,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '${model.questionsPassed.length} / ${model.currentQuestions.length}',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children:
                        buildQuestionsList(context, model.currentQuestions),
                    mainAxisAlignment: MainAxisAlignment.center,
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

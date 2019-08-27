import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/gallery.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';

class GameSummaryScreen extends StatelessWidget {
  Widget buildQuestionItem(BuildContext context, Question question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            question.isPassed ? Icons.check : Icons.close,
            size: 20.0,
            color:
                question.isPassed ? successColor : Theme.of(context).errorColor,
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

  openGallery(BuildContext context, FileSystemEntity item) {
    GalleryModel.of(context).setActive(item);

    Navigator.pushNamed(
      context,
      '/game-gallery',
    );
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            AppLocalizations.of(context).summaryHeader,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6.0),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              '${model.questionsPassed.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(
                                    color:
                                        Theme.of(context).textTheme.body1.color,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ScopedModelDescendant<GalleryModel>(
                    builder: (context, child, model) {
                  if (model.images.isEmpty) {
                    return Container();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: GalleryHorizontal(
                        items: model.images,
                        onTap: (item) => openGallery(context, item)),
                  );
                }),
                Expanded(
                  child: ListView(
                    children:
                        buildQuestionsList(context, model.questionsAnswered),
                  ),
                ),
                BottomButton(
                    child: Text(AppLocalizations.of(context).summaryBack),
                    onPressed: () {
                      if (!SettingsModel.of(context).isNotificationsEnabled) {
                        SettingsModel.of(context).enableNotifications();
                      }
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/gallery.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';
import 'package:zgadula/ui/templates/screen.dart';

class GameSummaryScreen extends StatelessWidget {
  Widget buildQuestionItem(BuildContext context, Question question) {
    if (question == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            question.isPassed ? Icons.check : Icons.close,
            size: 20.0,
            color: question.isPassed ? successColor : Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                question.name,
                style: Theme.of(context).textTheme.body1,
              ),
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
    var chunks = partition(questions, 2).toList();
    return List.generate(
        chunks.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                      child: buildQuestionItem(
                          context, chunks[index].elementAt(0))),
                  Expanded(
                      child: buildQuestionItem(
                          context,
                          chunks[index].length > 1
                              ? chunks[index].elementAt(1)
                              : null)),
                ],
              ),
            )).toList();
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
        return ScreenTemplate(
          child: SafeArea(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 8),
                      child: Text(
                        AppLocalizations.of(context).summaryHeader,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).accentColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Text(
                          model.questionsPassed.length.toString(),
                          style: Theme.of(context).textTheme.display2.copyWith(
                                color: Theme.of(context).textTheme.body1.color,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                ScopedModelDescendant<GalleryModel>(
                  builder: (context, child, model) {
                    if (model.images.isEmpty) {
                      return Container();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GalleryHorizontal(
                        items: model.images,
                        onTap: (item) => openGallery(context, item),
                      ),
                    );
                  },
                ),
                ListView(
                  padding: EdgeInsets.only(top: 16),
                  shrinkWrap: true,
                  children:
                      buildQuestionsList(context, model.questionsAnswered),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    indent: 32,
                    endIndent: 32,
                  ),
                ),
                RaisedButton.icon(
                  label: Text(AppLocalizations.of(context).summaryBack),
                  icon: Icon(Icons.play_circle_outline),
                  onPressed: () {
                    if (!SettingsModel.of(context).isNotificationsEnabled) {
                      SettingsModel.of(context).enableNotifications();
                    }
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

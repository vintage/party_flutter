import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/services/formatters.dart';
import 'package:zgadula/localizations.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/ui/shared/category_sample_question.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Container(
                          width: ThemeConfig.categoryImageSize,
                          height: ThemeConfig.categoryImageSize,
                          child: Hero(
                            tag: 'categoryImage-${model.currentCategory.name}',
                            child: ClipOval(
                              child: CategoryImage(
                                photo: model.currentCategory.getImagePath(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                          child: Text(
                              AppLocalizations.of(context).preparationPlay),
                          onPressed: () {
                            SettingsModel.of(context).increaseGamesPlayed();

                            Navigator.pushReplacementNamed(
                              context,
                              '/game-play',
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: ScopedModelDescendant<QuestionModel>(
                          builder: (context, child, model) {
                            return buildQuestionCards(
                              context,
                              model.sampleQuestions,
                            );
                          },
                        ),
                      ),
                      ScopedModelDescendant<SettingsModel>(
                        builder: (context, child, settingsModel) {
                          String timeDisplay = FormatterService.secondsToTime(
                              settingsModel.roundTime);

                          return Column(
                            children: <Widget>[
                              Slider(
                                value: settingsModel.roundTime.toDouble(),
                                min: 30.0,
                                max: 120.0,
                                divisions: 6,
                                onChanged: (value) => settingsModel
                                    .changeRoundTime(value.toInt()),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context).roundTime,
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    TextSpan(
                                      text: ' $timeDisplay',
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BottomButton(
                  child: Text(AppLocalizations.of(context).preparationBack),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildQuestionCards(BuildContext context, List<Question> questions) {
    return Center(
      child: Column(
        children: [
          Column(
            children: questions.asMap().keys.map((index) {
              var question = questions[index];

              return CategorySampleQuestion(
                index: index,
                question: question,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

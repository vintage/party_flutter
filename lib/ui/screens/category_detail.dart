import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/models/category.dart';
import 'package:zgadula/services/analytics.dart';

import 'package:zgadula/services/formatters.dart';
import 'package:zgadula/localizations.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/ui/templates/back_template.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';

class CategoryDetailScreen extends StatefulWidget {
  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  Widget buildFavorite({bool isFavorite, Function onPressed}) {
    return FloatingActionButton(
      elevation: 0.0,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      onPressed: onPressed,
    );
  }

  Widget buildContent(Category category) {
    return Container(
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
                      tag: 'categoryImage-${category.name}',
                      child: ClipOval(
                        child: CategoryImage(
                          photo: category.getImagePath(),
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                    child: Text(AppLocalizations.of(context).preparationPlay),
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
                        model.sampleQuestions,
                      );
                    },
                  ),
                ),
                ScopedModelDescendant<SettingsModel>(
                  builder: (context, child, settingsModel) {
                    String timeDisplay =
                        FormatterService.secondsToTime(settingsModel.roundTime);

                    return Column(
                      children: <Widget>[
                        Slider(
                          value: settingsModel.roundTime.toDouble(),
                          min: 30.0,
                          max: 120.0,
                          divisions: 3,
                          onChanged: (value) {
                            AnalyticsService.logEvent(
                                "settings_round_time", {"value": value});
                            settingsModel.changeRoundTime(value.toInt());
                          },
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
        ],
      ),
    );
  }

  Widget buildQuestionCards(List<Question> questions) {
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

  @override
  Widget build(BuildContext context) {
    return BackTemplate(
      child: ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) {
          var category = model.currentCategory;

          return Stack(
            children: [
              buildContent(category),
              Positioned(
                top: 10,
                right: 10,
                child: buildFavorite(
                  isFavorite: model.isFavorite(category),
                  onPressed: () => model.toggleFavorite(category),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

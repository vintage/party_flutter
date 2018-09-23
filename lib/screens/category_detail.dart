import 'package:flutter/material.dart';
import 'package:zgadula/localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/screens/category_play.dart';
import 'package:zgadula/components/bottom_button.dart';
import 'package:zgadula/components/category_image.dart';

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
                          width: 300.0,
                          height: 300.0,
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
                        child:
                            Text(AppLocalizations.of(context).preparationPlay),
                        onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryPlayScreen(),
                              ),
                            ),
                      ),
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
            children: questions
                .map(
                  (question) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              size: 16.0,
                              color: Theme.of(context).accentColor,
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
                      ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              AppLocalizations.of(context).moreQuestionsAvailable,
              style: Theme.of(context).textTheme.body2,
            ),
          ),
        ],
      ),
    );
  }
}

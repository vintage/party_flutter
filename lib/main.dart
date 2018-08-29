import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/screens/tutorial.dart';
import 'package:zgadula/screens/home.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel = CategoryModel();
    categoryModel.initialize();

    QuestionModel questionModel = QuestionModel();
    questionModel.initialize();

    TutorialModel tutorialModel = TutorialModel();
    tutorialModel.initialize();

    return ScopedModel<CategoryModel>(
      model: categoryModel,
      child: ScopedModel<QuestionModel>(
        model: questionModel,
        child: ScopedModel<TutorialModel>(
          model: tutorialModel,
          child: buildApp(),
        ),
      ),
    );
  }

  Widget buildApp() {
    return MaterialApp(
      title: 'Zgadula',
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pl', 'PL'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
      ),
      home: ScopedModelDescendant<TutorialModel>(
        builder: (context, child, model) =>
            model.isWatched ? HomeScreen() : TutorialScreen(),
      ),
    );
  }
}

void main() => runApp(App());

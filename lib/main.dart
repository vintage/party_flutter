import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/screens/tutorial.dart';
import 'package:zgadula/screens/home.dart';
import 'package:zgadula/services/language.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/store/settings.dart';

CategoryModel categoryModel;
QuestionModel questionModel;
TutorialModel tutorialModel;
SettingsModel settingsModel;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Refactor it
    if (categoryModel == null) {
      categoryModel = CategoryModel();
      categoryModel.initialize();
    }

    if (questionModel == null) {
      questionModel = QuestionModel();
      questionModel.initialize();
    }

    if (tutorialModel == null) {
      tutorialModel = TutorialModel();
      tutorialModel.initialize();
    }

    if (settingsModel == null) {
      settingsModel = SettingsModel();
      settingsModel.initialize();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScopedModel<CategoryModel>(
      model: categoryModel,
      child: ScopedModel<QuestionModel>(
        model: questionModel,
        child: ScopedModel<TutorialModel>(
            model: tutorialModel,
            child: ScopedModel<SettingsModel>(
              model: settingsModel,
              child: buildApp(context),
            )),
      ),
    );
  }

  Widget buildApp(BuildContext context) {
    return ScopedModelDescendant<SettingsModel>(
      builder: (context, child, model) => MaterialApp(
            title: 'Zgadula',
            localizationsDelegates: [
              SettingsLocalizationsDelegate(
                model.language == null ? null : Locale(model.language, ''),
              ),
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales:
                LanguageService.getCodes().map((code) => Locale(code, '')),
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColorDark: Color(0xFF455A64),
              primaryColorLight: Color(0xFFCFD8DC),
              primaryColor: Color(0xFF607D8B),
              accentColor: Color(0xFF4CAF50),
              iconTheme: IconThemeData(
                color: Color(0xFFFFFFFF),
              ),
              dividerColor: Color(0xFFBDBDBD),
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Color(0xFFEEEEEE),
                    displayColor: Color(0xFF757575),
                  ),
              buttonTheme: ButtonThemeData(
                height: 52.0,
                minWidth: 120.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            home: ScopedModelDescendant<TutorialModel>(
                builder: (context, child, model) =>
                    model.isWatched ? HomeScreen() : TutorialScreen()),
          ),
    );
  }
}

void main() => runApp(App());

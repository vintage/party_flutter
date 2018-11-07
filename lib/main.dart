import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/components/screen_loader.dart';

import 'package:zgadula/theme.dart';
import 'package:zgadula/localizations.dart';
import 'package:zgadula/screens/tutorial.dart';
import 'package:zgadula/screens/home.dart';
import 'package:zgadula/services/language.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/store/language.dart';

CategoryModel categoryModel;
QuestionModel questionModel;
TutorialModel tutorialModel;
SettingsModel settingsModel;
LanguageModel languageModel;

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

    if (languageModel == null) {
      languageModel = LanguageModel();
      languageModel.initialize();
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
            child: ScopedModel<LanguageModel>(
              model: languageModel,
              child: buildApp(context),
            )
          ),
        ),
      ),
    );
  }

  Widget buildApp(BuildContext context) {
    return ScopedModelDescendant<LanguageModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return ScreenLoader();
        }

        bool languageSet = model.language != null;
        if (languageSet) {
          CategoryModel.of(context).load(model.language);
          QuestionModel.of(context).load(model.language);
        }

        return MaterialApp(
          title: 'Zgadula',
          localeResolutionCallback: (locale, locales) {
            if (!languageSet) {
              model.changeLanguage(locale.languageCode);
            }
          },
          localizationsDelegates: [
            SettingsLocalizationsDelegate(
              languageSet ? Locale(model.language, '') : null,
            ),
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales:
              LanguageService.getCodes().map((code) => Locale(code, '')),
          theme: createTheme(context),
          home: ScopedModelDescendant<TutorialModel>(
            builder: (context, child, model) {
              return model.isWatched ? HomeScreen() : TutorialScreen();
            },
          ),
        );
      },
    );
  }
}

void main() => runApp(App());

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screen/screen.dart';
import 'package:zgadula/screens/category_detail.dart';
import 'package:zgadula/screens/category_play.dart';
import 'package:zgadula/screens/game_score.dart';
import 'package:zgadula/screens/settings.dart';
import 'package:zgadula/screens/tutorial.dart';
import 'package:zgadula/services/analytics.dart';

import 'package:zgadula/theme.dart';
import 'package:zgadula/localizations.dart';
import 'package:zgadula/screens/home.dart';
import 'package:zgadula/components/screen_loader.dart';
import 'package:zgadula/services/language.dart';
import 'package:zgadula/store/store.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/store/settings.dart';
import 'package:zgadula/store/language.dart';

class App extends StatelessWidget {
  final Map<Type, StoreModel> stores = {};

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (stores.length == 0) {
      stores.addAll({
        CategoryModel: CategoryModel(),
        QuestionModel: QuestionModel(),
        TutorialModel: TutorialModel(),
        SettingsModel: SettingsModel(),
        LanguageModel: LanguageModel(),
      });
      stores.values.forEach((store) => store.initialize());
    }

    return ScopedModel<CategoryModel>(
      model: stores[CategoryModel],
      child: ScopedModel<QuestionModel>(
        model: stores[QuestionModel],
        child: ScopedModel<TutorialModel>(
          model: stores[TutorialModel],
          child: ScopedModel<SettingsModel>(
            model: stores[SettingsModel],
            child: ScopedModel<LanguageModel>(
              model: stores[LanguageModel],
              child: buildApp(context),
            ),
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
          title: 'Mima',
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
          home: HomeScreen(),
          routes: {
            '/category': (context) => CategoryDetailScreen(),
            '/play': (context) => CategoryPlayScreen(),
            '/game-score': (context) => GameScoreScreen(),
            '/settings': (context) => SettingsScreen(),
            '/tutorial': (context) => TutorialScreen(),
          },
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: AnalyticsService.analytics),
          ],
        );
      },
    );
  }
}

void main() => runApp(App());

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localizations.dart';
import 'ui/theme.dart';
import 'ui/shared/widgets.dart';
import 'ui/screens/category_detail.dart';
import 'ui/screens/game_play.dart';
import 'ui/screens/game_summary.dart';
import 'ui/screens/game_gallery.dart';
import 'ui/screens/settings.dart';
import 'ui/screens/tutorial.dart';
import 'ui/screens/home.dart';
import 'ui/screens/contributors.dart';
import 'services/analytics.dart';
import 'services/language.dart';
import 'services/ads.dart';
import 'services/crashlytics.dart';
import 'services/notifications.dart';
import 'repository/category.dart';
import 'repository/question.dart';
import 'repository/language.dart';
import 'repository/settings.dart';
import 'repository/tutorial.dart';
import 'repository/contributor.dart';
import 'store/store.dart';
import 'store/category.dart';
import 'store/question.dart';
import 'store/tutorial.dart';
import 'store/settings.dart';
import 'store/language.dart';
import 'store/gallery.dart';
import 'store/contributor.dart';

class App extends StatelessWidget {
  final Map<Type, StoreModel> stores = {};

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (
        BuildContext context,
        AsyncSnapshot<SharedPreferences> snapshot,
      ) {
        if (snapshot.data == null) {
          return ScreenLoader();
        }

        return buildStore(context, snapshot.data);
      },
    );
  }

  Widget buildStore(BuildContext context, SharedPreferences storage) {
    if (stores.isEmpty) {
      stores.addAll({
        CategoryModel: CategoryModel(CategoryRepository(storage: storage)),
        QuestionModel: QuestionModel(QuestionRepository()),
        TutorialModel: TutorialModel(TutorialRepository(storage: storage)),
        SettingsModel: SettingsModel(SettingsRepository(storage: storage)),
        LanguageModel: LanguageModel(LanguageRepository(storage: storage)),
        GalleryModel: GalleryModel(),
        ContributorModel: ContributorModel(ContributorRepository()),
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
              child: ScopedModel<GalleryModel>(
                model: stores[GalleryModel],
                child: ScopedModel<ContributorModel>(
                  model: stores[ContributorModel],
                  child: buildApp(context),
                ),
              ),
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
          title: 'Zgadula',
          localeResolutionCallback: (locale, locales) {
            if (!languageSet) {
              model.changeLanguage(locale.languageCode);
            }

            return locale;
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
            '/game-play': (context) => GamePlayScreen(),
            '/game-summary': (context) => GameSummaryScreen(),
            '/game-gallery': (context) => GameGalleryScreen(),
            '/settings': (context) => SettingsScreen(),
            '/tutorial': (context) => TutorialScreen(),
            '/contributors': (context) => ContributorsScreen(),
          },
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: AnalyticsService.analytics),
          ],
        );
      },
    );
  }
}

void main() {
  AdsService.initialize();
  CrashlyticsService.initialize();
  NotificationsService.initialize();

  runApp(App());
}

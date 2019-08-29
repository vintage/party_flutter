import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/ui/screens/category_list.dart';
import 'package:zgadula/ui/screens/category_favorites.dart';
import 'package:zgadula/ui/screens/settings.dart';
import 'package:zgadula/localizations.dart';
import '../shared/widgets.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    if (!isTutorialWatched()) {
      // Cannot navigate instantly
      // https://github.com/flutter/flutter/issues/19330
      Future.delayed(Duration(milliseconds: 10)).then((_) {
        Navigator.pushNamed(
          context,
          '/tutorial',
        );
      });
    }
  }

  bool isTutorialWatched() {
    return TutorialModel.of(context).isWatched;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) => ScopedModelDescendant<QuestionModel>(
        builder: (context, child, qModel) {
          if (model.isLoading || qModel.isLoading || !isTutorialWatched()) {
            return ScreenLoader();
          }

          return Scaffold(
            body: DefaultTabController(
              length: 3,
              child: Scaffold(
                bottomNavigationBar: Container(
                  color: primaryDarkColor,
                  height: 60,
                  child: TabBar(
                    labelColor: Theme.of(context).buttonColor,
                    unselectedLabelColor: primaryLightColor,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(icon: Icon(Icons.play_arrow)),
                      Tab(icon: Icon(Icons.favorite)),
                      Tab(icon: Icon(Icons.settings)),
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CategoryListScreen(),
                    CategoryFavoritesScreen(),
                    SettingsScreen(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/ui/screens/category_list.dart';
import 'package:zgadula/ui/screens/category_favorites.dart';
import 'package:zgadula/ui/screens/settings.dart';
import '../shared/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int tabIndex = 0;
  List<Widget> tabsContent = [
    CategoryListScreen(),
    CategoryFavoritesScreen(),
    SettingsScreen(),
  ];

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

  void onTabChange(int index) {
    setState(() {
      tabIndex = index;
    });
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
                bottomNavigationBar: BottomNavigationBar(
                  onTap: onTabChange,
                  currentIndex: tabIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.play_arrow),
                      title: new Text('Play'),
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.favorite),
                      title: new Text('Favorite'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ],
                ),
                body: tabsContent[tabIndex],
              );
            },
          ),
    );
  }
}

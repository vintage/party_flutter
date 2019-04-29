import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const settingsAnimationDuration = Duration(milliseconds: 2600);

  AnimationController settingsAnimationController;
  Animation<double> settingsAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();

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

  @override
  void dispose() {
    settingsAnimationController?.dispose();
    super.dispose();
  }

  initAnimations() {
    settingsAnimationController =
        AnimationController(vsync: this, duration: settingsAnimationDuration);
    settingsAnimation =
        Tween<double>(begin: 0, end: 1).animate(settingsAnimationController)
          ..addStatusListener((status) {
            Future.delayed(settingsAnimationDuration).then((_) {
              if (status == AnimationStatus.completed) {
                settingsAnimationController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                settingsAnimationController.forward();
              }
            });
          });
    settingsAnimationController.forward();
  }

  bool isTutorialWatched() {
    return TutorialModel.of(context).isWatched;
  }

  Widget buildAppBar(context) {
    return Header(
      headerText: "Zgadula",
      actions: [
        RotationTransition(
          turns: settingsAnimation,
          child: IconButton(
            icon: Icon(Icons.settings),
            iconSize: ThemeConfig.appBarIconSize,
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildContentLoading() {
    return SliverFillRemaining(
      child: ScreenLoader(),
    );
  }

  Widget buildContentLoaded(
    BuildContext context,
    CategoryModel model,
    QuestionModel qModel,
  ) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(0.0),
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            crossAxisCount: ThemeConfig.categoriesGridCount,
            children: model.categories.asMap().keys.map((index) {
              var category = model.categories[index];

              return CategoryListItem(
                index: index,
                category: category,
                isFavorite: model.favourites.contains(category.id),
                onTap: () {
                  model.setCurrent(category);
                  qModel.generateSampleQuestions(category.id);

                  Navigator.pushNamed(
                    context,
                    '/category',
                  );
                },
                onFavoriteToggle: () => model.toggleFavorite(category),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildContent(context) {
    return ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) =>
            ScopedModelDescendant<QuestionModel>(
              builder: (context, child, qModel) {
                if (model.isLoading ||
                    qModel.isLoading ||
                    !isTutorialWatched()) {
                  return buildContentLoading();
                }

                return buildContentLoaded(context, model, qModel);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildAppBar(context),
          buildContent(context),
        ],
      ),
    );
  }
}

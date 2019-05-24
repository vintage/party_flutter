import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/models/category.dart';
import 'package:zgadula/services/analytics.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/store/category.dart';
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

  Widget buildRoundTimeSelectItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
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
                ScopedModelDescendant<SettingsModel>(
                  builder: (context, child, settingsModel) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: RichText(
                            text: TextSpan(
                              text: AppLocalizations.of(context).roundTime,
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                        CupertinoSegmentedControl(
                          borderColor: Colors.white,
                          selectedColor: secondaryColor,
                          pressedColor: secondaryDarkColor,
                          unselectedColor: Theme.of(context).primaryColor,
                          children: {
                            30: buildRoundTimeSelectItem("30s"),
                            60: buildRoundTimeSelectItem("60s"),
                            90: buildRoundTimeSelectItem("90s"),
                            120: buildRoundTimeSelectItem("120s"),
                          },
                          groupValue: settingsModel.roundTime.toDouble(),
                          onValueChanged: (value) {
                            AnalyticsService.logEvent(
                                "settings_round_time", {"value": value});
                            settingsModel.changeRoundTime(value.toInt());
                          },
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).preparationPlay),
                    onPressed: () {
                      SettingsModel.of(context).increaseGamesPlayed();

                      Navigator.pushReplacementNamed(
                        context,
                        '/game-play',
                      );
                    },
                  ),
                ),
              ],
            ),
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

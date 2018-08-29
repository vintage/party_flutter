import 'package:flutter/material.dart';
import 'package:zgadula/localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/screens/category_play.dart';
import 'package:zgadula/components/tutorial_item.dart';
import 'package:zgadula/components/category_image.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: Hero(
                          tag: 'categoryImage-${model.currentCategory.name}',
                          child: ClipOval(
                            child: CategoryImage(
                              photo: model.currentCategory.getImagePath(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TutorialItem(
                            title: "1",
                            description: AppLocalizations.of(context).preparationFirstTip,
                          ),
                          TutorialItem(
                            title: "2",
                            description: AppLocalizations.of(context).preparationSecondTip,
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text(AppLocalizations.of(context).preparationPlay),
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPlayScreen(),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
                RaisedButton(
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
}

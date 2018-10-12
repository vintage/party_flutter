import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/screens/category_detail.dart';
import 'package:zgadula/components/category_list_item.dart';

class HomeScreen extends StatelessWidget {
  Widget buildAppBar() {
    return SliverAppBar(
      titleSpacing: 8.0,
      floating: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(
          'assets/images/icon.png',
        ),
      ),
      title: Text(
        'Zgadula',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'FlamanteRoma',
        ),
      ),
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildCategoryList(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: ScopedModelDescendant<QuestionModel>(
          builder: (context, child, qModel) {
            return GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(0.0),
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              crossAxisCount: isPortrait ? 2 : 3,
              children: model.categories
                  .map(
                    (category) => CategoryListItem(
                          category: category,
                          isFavorite: model.favourites.contains(category.id),
                          onTap: () {
                            model.setCurrent(category);
                            qModel.generateSampleQuestions(category.id);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailScreen(),
                              ),
                            );
                          },
                          onFavoriteToggle: () =>
                              model.toggleFavorite(category),
                        ),
                  )
                  .toList(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                buildCategoryList(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}

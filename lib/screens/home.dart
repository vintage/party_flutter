import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/screens/category_detail.dart';
import 'package:zgadula/components/category_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: GridView.count(
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
            ),
          ),
        );
      },
    );
  }
}

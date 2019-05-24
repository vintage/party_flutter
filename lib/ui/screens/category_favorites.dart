import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import '../shared/widgets.dart';

class CategoryFavoritesScreen extends StatefulWidget {
  @override
  CategoryFavoritesScreenState createState() {
    return new CategoryFavoritesScreenState();
  }
}

class CategoryFavoritesScreenState extends State<CategoryFavoritesScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<CategoryModel>(
          builder: (context, child, model) {
        if (model.favourites.isEmpty) {
          return Opacity(
            opacity: 0.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.grid_on, size: 96),
                  Container(
                    width: 160,

                    child: Text(
                      "Dodaj ulubione kategorie aby móc je szybko uruchamiać",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return CategoryList(categories: model.favourites);
      }),
    );
  }
}

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
  Widget buildContent(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) =>
          CategoryList(categories: model.favourites),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildContent(context),
        ],
      ),
    );
  }
}

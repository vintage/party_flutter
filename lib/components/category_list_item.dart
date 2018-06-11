import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({
    this.category,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  final Category category;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => onTap(),
      child: new Card(
          child: new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(category.getImagePath()),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Stack(
                children: buildCategoryBoxChild(context),
              ))),
    );
  }

  List<Widget> buildCategoryBoxChild(BuildContext context) {
    List<Widget> child = new List();

    child.add(new Positioned(
      right: 0.0,
      left: 0.0,
      bottom: 0.0,
      child: new Container(
        height: 35.0,
        decoration: new BoxDecoration(color: Theme.of(context).buttonColor),
        child: new Center(child: new Text(category.name)),
      ),
    ));

    return child;
  }
}

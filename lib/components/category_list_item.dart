import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({
    this.category,
    this.onTap,
    this.onTapDown,
    this.onFavoriteToggle,
    this.showTitle = false,
    this.isFavorite = false,
  });

  final Category category;
  final bool showTitle;
  final bool isFavorite;
  final VoidCallback onTapDown;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => onTap(),
      onTapDown: (e) => onTapDown(),
      child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(category.getImagePath()),
              fit: BoxFit.cover,
            ),
          ),
          child: new Stack(
            children: buildCategoryBoxChild(category),
          )),
    );
  }

  List<Widget> buildCategoryBoxChild(Category category) {
    List<Widget> child = new List();

    if (showTitle) {
      child.add(new Center(
        child: new Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: new Text(category.name,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ),
      ));
    }

    IconData iconData = isFavorite ? Icons.star : Icons.star_border;
    Icon icon = new Icon(iconData, size: 38.0, color: Colors.amber);

    child.add(new Positioned(
      right: 0.0,
      bottom: 2.0,
      child: new IconButton(icon: icon, onPressed: () => onFavoriteToggle()),
    ));

    return child;
  }
}

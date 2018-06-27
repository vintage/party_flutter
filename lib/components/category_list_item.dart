import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/components/category_image.dart';

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
    return Stack(
      children: [
        Hero(
          tag: 'categoryImage-${category.name}',
          child: CategoryImage(photo: category.getImagePath(), onTap: onTap),
        ),
        Positioned(
          right: 0.0,
          left: 0.0,
          bottom: 0.0,
          child: Opacity(
            opacity: 0.75,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              height: 45.0,
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                category.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Hero(
            tag: 'categoryImage-${category.name}',
            child: CategoryImage(photo: category.getImagePath()),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10.0),
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.35),
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'FlamanteRoma',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

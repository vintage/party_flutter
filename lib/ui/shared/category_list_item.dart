import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/models/category.dart';
import 'category_image.dart';

class CategoryListItem extends StatefulWidget {
  CategoryListItem({
    this.index,
    this.category,
    this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
  });

  final int index;
  final Category category;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem>
    with TickerProviderStateMixin {
  static const textAnimationDuration = Duration(milliseconds: 1000);

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  initAnimations() {
    int index = widget.index;
    animationController =
        AnimationController(vsync: this, duration: textAnimationDuration);
    animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);

    Future.delayed(Duration(milliseconds: 75 * min(index, 8))).then((_) {
    animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: animation,
        child: Stack(
          children: [
            Hero(
              tag: 'categoryImage-${widget.category.name}',
              child: CategoryImage(photo: widget.category.getImagePath()),
            ),
            Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10.0),
                height: ThemeConfig.categoriesTextHeight,
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
                  widget.category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ThemeConfig.categoriesTextSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

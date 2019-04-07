import 'dart:async';

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
  static const imageAnimationDuration = Duration(milliseconds: 600);
  static const textAnimationDuration = Duration(milliseconds: 750);

  AnimationController imageAnimationController;
  Animation<double> imageAnimation;
  AnimationController textAnimationController;
  Animation<Offset> textAnimation;
  bool isTextVisible = false;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  initAnimations() {
    int index = widget.index;
    double offsetX = (index % 2 == 0 ? -1 : 1) * 1.5;
    double offsetY = 0;

    textAnimationController =
        AnimationController(vsync: this, duration: textAnimationDuration);
    textAnimation =
        Tween<Offset>(begin: Offset(offsetX, offsetY), end: Offset.zero)
            .animate(textAnimationController);

    imageAnimationController =
        AnimationController(vsync: this, duration: imageAnimationDuration);
    imageAnimation =
    Tween<double>(begin: 0, end: 1).animate(imageAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isTextVisible = true;
          });

          textAnimationController.forward();
        }
      });

    Future.delayed(Duration(milliseconds: 200 * index)).then((_) {
      imageAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Hero(
            tag: 'categoryImage-${widget.category.name}',
            child: ScaleTransition(
              scale: imageAnimation,
              child: CategoryImage(photo: widget.category.getImagePath()),
            ),
          ),
          Visibility(
            visible: isTextVisible,
            child: Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: SlideTransition(
                position: textAnimation,
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
            ),
          ),
        ],
      ),
    );
  }
}

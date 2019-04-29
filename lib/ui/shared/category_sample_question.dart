import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/models/question.dart';

class CategorySampleQuestion extends StatefulWidget {
  CategorySampleQuestion({
    this.index,
    this.question,
  });

  final int index;
  final Question question;

  @override
  _CategorySampleQuestionState createState() => _CategorySampleQuestionState();
}

class _CategorySampleQuestionState extends State<CategorySampleQuestion>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animation;

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
    double offsetX = (index % 2 == 0 ? -1 : 1) * 0.8;
    double offsetY = 0;

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<Offset>(begin: Offset(offsetX, offsetY), end: Offset.zero)
        .animate(animationController);

    Future.delayed(Duration(milliseconds: 200 * index)).then((_) {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ThemeConfig.categorySampleQuestionPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              size: 16.0,
              color: Theme.of(context).accentColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.question.name,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .merge(TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

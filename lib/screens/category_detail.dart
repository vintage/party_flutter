import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/services/question.dart';
import 'package:zgadula/screens/category_play.dart';
import 'package:zgadula/components/tutorial_item.dart';
import 'package:zgadula/components/category_image.dart';

class CategoryDetailScreen extends StatefulWidget {
  CategoryDetailScreen({Key key, this.category}) : super(key: key);

  final Category category;

  @override
  CategoryDetailScreenStage createState() => CategoryDetailScreenStage();
}

class CategoryDetailScreenStage extends State<CategoryDetailScreen> {
  Future<List<Question>> getQuestions() async {
    return await QuestionService.getByCategoryId(widget.category.id)
      ..shuffle()
      ..sublist(0, 10);
  }

  playCategory() async {
    final questions = await getQuestions();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPlayScreen(questions: questions),
      ),
    );
  }

  goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Category category = widget.category;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    child: Hero(
                      tag: 'categoryImage-${category.name}',
                      child: ClipOval(
                        child: CategoryImage(
                          photo: category.getImagePath(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TutorialItem(
                        title: "1",
                        description:
                            "Place the phone on the forehead and guess the displayed word with help of your friends."
                      ),
                      TutorialItem(
                        title: "2",
                        description:
                            "Tap the screen once if you want to pass, and tap it twice when correctly guessed.",
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text("Play"),
                    onPressed: playCategory,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
            RaisedButton(
              child: Text("Back"),
              onPressed: goBack,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/services/question.dart';
import 'package:zgadula/screens/category_play.dart';
import 'package:zgadula/components/tutorial_item.dart';

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
          color: Theme.of(context).backgroundColor,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          category.getImagePath(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TutorialItem(
                        title: "1",
                        description:
                            "Przyłóż telefon do czoła i zgadnij hasło kierując się podpowiedziami znajomych",
                      ),
                      TutorialItem(
                        title: "2",
                        description:
                            "Wychyl telefon do przodu jeśli odgadłeś, lub do tyłu aby pokazać kolejne pytanie aaaaaa",
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

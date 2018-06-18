import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/services/question.dart';
import 'package:zgadula/screens/category_play.dart';

class CategoryDetailScreen extends StatefulWidget {
  CategoryDetailScreen({Key key, this.category}) : super(key: key);

  final Category category;

  @override
  CategoryDetailScreenStage createState() => new CategoryDetailScreenStage();
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
        new MaterialPageRoute(
            builder: (context) =>
                new CategoryPlayScreen(questions: questions)));
  }

  goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Category category = widget.category;

    return new Scaffold(
        body: new Container(
            decoration:
                new BoxDecoration(color: Theme.of(context).backgroundColor),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Expanded(
                    child: new Column(
                  children: <Widget>[
                    new Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: new AssetImage(category.getImagePath()),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(child: Center(child: Text("1"))),
                        Expanded(child: Center(child: Text("2"))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: Center(child: Text("3"))),
                        Expanded(child: Center(child: Text("4"))),
                      ],
                    ),
                    new RaisedButton(
                        child: const Text("Play"), onPressed: playCategory),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )),
                new RaisedButton(child: const Text("Back"), onPressed: goBack),
              ],
            )));
  }
}

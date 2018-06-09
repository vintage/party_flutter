import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/models/question.dart';
import 'package:zgadula/screens/category_play.dart';

class CategoryDetailScreen extends StatefulWidget {
  CategoryDetailScreen({Key key, this.category}) : super(key: key);

  final Category category;

  @override
  CategoryDetailScreenStage createState() => new CategoryDetailScreenStage();
}

class CategoryDetailScreenStage extends State<CategoryDetailScreen> {
  List<Question> getQuestions() {
    return widget.category.questions..shuffle()..sublist(0, 10);
  }

  playCategory() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new CategoryPlayScreen(questions: getQuestions())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.category.name),
      ),
      body:
          new RaisedButton(child: const Text("Play"), onPressed: playCategory),
    );
  }
}

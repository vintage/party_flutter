import 'package:flutter/material.dart';

import 'package:zgadula/models/category.dart';

class CategoryDetailScreen extends StatefulWidget {
  CategoryDetailScreen({Key key, this.category}) : super(key: key);

  final Category category;

  @override
  CategoryDetailScreenStage createState() => new CategoryDetailScreenStage();
}

class CategoryDetailScreenStage extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.category.name),
      ),
      body: new ListView(
        children: widget.category.questions
            .map((question) => new Text(question.name))
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';

class SettingsScreen extends StatelessWidget {
  Widget buildAppBar(context) {
    return SliverAppBar(
      titleSpacing: 8.0,
      floating: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      title: Text(
        'Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'FlamanteRoma',
        ),
      ),
    );
  }

  Widget buildContent(context) {
    return ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: ScopedModelDescendant<QuestionModel>(
          builder: (context, child, qModel) {
            return Text('OK');
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                buildContent(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}

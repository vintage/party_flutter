import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/screens/tutorial.dart';

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
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.help),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TutorialScreen(),
              ),
            );
          },
        ),
      ],
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
            return Column(
              children: <Widget> [
                SwitchListTile(
                  title: Text('Sound'),
                  subtitle: Text('Explain how it works'),
                  value: true,
                  onChanged: (bool value) {  },
                  secondary: Icon(Icons.music_note),
                ),
                SwitchListTile(
                  title: Text('Rotation control'),
                  subtitle: Text('Explain how it works'),
                  value: true,
                  onChanged: (bool value) {  },
                  secondary: Icon(Icons.screen_rotation),
                ),
              ],
            );
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

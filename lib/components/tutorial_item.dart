import 'package:flutter/material.dart';

class TutorialItem extends StatelessWidget {
  TutorialItem({
    this.title,
    this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

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
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(description, textAlign: TextAlign.center),
              ),
            ),
          ),
          Positioned(
            top: -24.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 62.0,
              height: 62.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
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

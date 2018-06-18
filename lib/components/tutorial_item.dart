import 'package:flutter/material.dart';

class TutorialItem extends StatelessWidget {
  TutorialItem({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return new Expanded(child: Center(child: Text(text)));
  }
}

import 'package:flutter/material.dart';

class FlagImage extends StatelessWidget {
  FlagImage({
    Key key,
    this.country,
  }) : super(key: key);

  final String country;

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Image.asset(
        'assets/images/flags/$country.png',
        fit: BoxFit.cover,
        width: 36.0,
        height: 24.0,
      ),
    );
  }
}

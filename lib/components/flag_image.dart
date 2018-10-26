import 'package:flutter/material.dart';

class FlagImage extends StatelessWidget {
  FlagImage({
    Key key,
    this.country,
  }) : super(key: key);

  final String country;

  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: Image.asset(
       'assets/images/flags/$country.png',
        fit: BoxFit.cover,
        width: 42.0,
        height: 28.0,
      ),
    );
  }
}

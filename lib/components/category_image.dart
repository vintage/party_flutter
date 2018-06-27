import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  CategoryImage({
    Key key,
    this.photo,
    this.onTap,
  }) : super(key: key);

  final String photo;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onTap,
        child: new Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  CategoryImage({
    Key key,
    this.photo,
  }) : super(key: key);

  final String photo;

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Image.asset(
            photo,
            fit: BoxFit.contain,
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            top: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

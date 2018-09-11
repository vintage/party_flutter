import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final child;
  final Function onPressed;

  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ButtonTheme(
        shape: BeveledRectangleBorder(),
        child: RaisedButton(
          color: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

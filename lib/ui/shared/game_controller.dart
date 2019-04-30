import 'package:flutter/material.dart';

class GameController extends StatefulWidget {
  GameController({
    Key key,
    this.child,
    this.alignment,
    this.color,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Alignment alignment;
  final Color color;
  final Function onTap;

  @override
  _GameControllerState createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          alignment: widget.alignment,
          child: Opacity(opacity: 0.6, child: widget.child),
          height: double.infinity,
          decoration: BoxDecoration(color: widget.color),
        ),
      ),
    );
  }
}

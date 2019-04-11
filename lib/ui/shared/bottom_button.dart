import 'package:flutter/material.dart';

import '../theme.dart';

class BottomButton extends StatefulWidget {
  BottomButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final child;
  final Function onPressed;

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  initAnimations() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation =
        Tween<Offset>(begin: Offset(0, 1.5), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SlideTransition(
        position: animation,
        child: SizedBox(
          height: ThemeConfig.backButtonHeight,
          child: ButtonTheme(
            shape: BeveledRectangleBorder(),
            child: RaisedButton(
              color: primaryDarkColor,
              textColor: Colors.white,
              child: widget.child,
              onPressed: widget.onPressed,
            ),
          ),
        ),
      ),
    );
  }
}

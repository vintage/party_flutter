import 'package:flutter/material.dart';

class BackTemplate extends StatefulWidget {
  BackTemplate({
    @required this.child,
    this.onBack,
  });

  final Widget child;
  final Function onBack;

  @override
  BackTemplateState createState() => BackTemplateState();
}

class BackTemplateState extends State<BackTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: () => widget.onBack != null
                    ? widget.onBack()
                    : Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

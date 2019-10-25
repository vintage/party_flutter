import 'package:flutter/material.dart';

class ScreenTemplate extends StatelessWidget {
  ScreenTemplate({
    @required this.child,
    this.showBack = false,
    this.onBack,
  });

  final Widget child;
  final bool showBack;
  final Function onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 0.9],
            colors: [
              Color(0xFF141E30),
              Color(0xFF243B55),
            ],
          ),
        ),
        child: Stack(
          children: [
            child,
            showBack || onBack != null
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () =>
                            onBack != null ? onBack() : Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  )
                : null,
          ].where((o) => o != null).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme.dart';

class Header extends StatefulWidget {
  Header({
    Key key,
    this.headerText,
    this.actions,
  }) : super(key: key);

  final String headerText;
  final List<Widget> actions;

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      expandedHeight: ThemeConfig.appBarHeight,
      floating: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      title: Text(
        widget.headerText,
        style: TextStyle(
          fontSize: ThemeConfig.appBarFontSize,
        ),
      ),
      actions: widget.actions,
    );
  }
}

import 'package:flutter/material.dart';

class _StartFloatFabLocation extends FloatingActionButtonLocation {
  const _StartFloatFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(20, 40);
  }
}

class CustomFloatingActionButtonLocation {
  static const FloatingActionButtonLocation startFloat =
      _StartFloatFabLocation();
}

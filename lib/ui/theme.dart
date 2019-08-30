import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

const Color primaryColor = Color(0xFF102636);
const Color primaryDarkColor = Color(0xFF0a1822);
const Color primaryLightColor = Color(0xFF16344a);

const Color secondaryColor = Color(0xFF984E99);
const Color secondaryDarkColor = Color(0xFF874588);
const Color secondaryLightColor = Color(0xFFa857a9);

const Color successColor = Colors.green;

const Color textColor = Color(0xFFEEEEEE);

final isTablet = Device.get().isTablet;

ThemeData createTheme(BuildContext context) {
  ThemeData theme = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
    buttonColor: secondaryColor,
    backgroundColor: primaryDarkColor,
    indicatorColor: secondaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColorDark: primaryDarkColor,
    primaryColorLight: primaryLightColor,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    toggleableActiveColor: secondaryLightColor,
    iconTheme: IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    dividerColor: Colors.white30,
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: Color(0xFF757575),
          fontSizeFactor: isTablet ? 1.75 : 1.0,
        ),
    buttonTheme: ButtonThemeData(
      height: isTablet ? 56.0 : 42.0,
      minWidth: 180,
      buttonColor: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000),
      ),
    ),
    sliderTheme: SliderTheme.of(context).copyWith(
      activeTickMarkColor: Colors.transparent,
      activeTrackColor: secondaryDarkColor,
      thumbColor: secondaryColor,
      inactiveTickMarkColor: secondaryColor,
      inactiveTrackColor: primaryDarkColor,
      overlayColor: secondaryLightColor.withOpacity(0.5),
    ),
  );

  return theme;
}

class ThemeConfig {
  static final appBarHeight = isTablet ? 74.0 : 32.0;
  static final appBarIconSize = isTablet ? 50.0 : 24.0;
  static final appBarFontSize = isTablet ? 36.0 : 20.0;

  static final backButtonHeight = isTablet ? 80.0 : 50.0;

  static final categoriesGridCount = isTablet ? 3 : 2;
  static final categoriesTextHeight = isTablet ? 55.0 : 35.0;
  static final categoriesTextSize = isTablet ? 22.0 : 14.0;
  static final categoriesMetaSize = isTablet ? 14.0 : 10.0;
  static final categoryImageSize = isTablet ? 280.0 : 170.0;

  static final fullScreenIconSize = isTablet ? 164.0 : 96.0;
}

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF102636);
const Color primaryDarkColor = Color(0xFF0a1822);
const Color primaryLightColor = Color(0xFF16344a);

const Color secondaryColor = Color(0xFF984E99);
const Color secondaryDarkColor = Color(0xFF874588);
const Color secondaryLightColor = Color(0xFFa857a9);

const Color textColor = Color(0xFFEEEEEE);

ThemeData createTheme(BuildContext context) {
  ThemeData theme = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
    buttonColor: secondaryColor,
    backgroundColor: primaryDarkColor,
    indicatorColor: secondaryColor,
    scaffoldBackgroundColor: primaryColor,
    primaryColorDark: primaryDarkColor,
    primaryColorLight: primaryLightColor,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    toggleableActiveColor: secondaryLightColor,
    iconTheme: IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    dividerColor: secondaryColor,
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: Color(0xFF757575),
        ),
    buttonTheme: ButtonThemeData(
      height: 52.0,
      minWidth: 120.0,
      buttonColor: secondaryColor,
      highlightColor: secondaryLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
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

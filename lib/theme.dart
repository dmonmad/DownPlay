import 'package:flutter/material.dart';
import 'package:downplay/consts.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: "Roboto"),
    primaryTextTheme: ThemeData.light().textTheme.apply(fontFamily: "Roboto"),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: "Roboto"),
    primaryTextTheme: ThemeData.dark().textTheme.apply(fontFamily: "Roboto"),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:downplay/screens/pages/home_page.dart';
import 'package:downplay/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DownPlay',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yt_viewer/screens/home/home_page.dart';
import 'package:yt_viewer/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}

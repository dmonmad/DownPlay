import 'package:downplay/providers/DownloadsProvider.dart';
import 'package:downplay/screens/pages/DownloadsPage.dart';
import 'package:downplay/screens/pages/PlaylistDownloadPage.dart';
import 'package:downplay/screens/pages/SettingsPage.dart';
import 'package:downplay/screens/pages/VideoSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:downplay/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DownloadsProvider>(
            create: (context) => DownloadsProvider())
      ],
      child: MaterialApp(
        title: 'DownPlay',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.light,
        initialRoute: '/video',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/video': (context) => VideoSearchPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/playlist': (context) => PlayListDownloadPage(),
          '/downloads': (context) => DownloadsPage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}

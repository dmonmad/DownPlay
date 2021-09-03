import 'package:downplay/components/appBar.dart';
import 'package:downplay/components/drawer.dart';
import 'package:downplay/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListDownloadPage extends StatefulWidget {
  const PlayListDownloadPage() : super();

  @override
  _PlayListDownloadPageState createState() => _PlayListDownloadPageState();
}

class _PlayListDownloadPageState extends State<PlayListDownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, 'Settings'),
        drawer: buildDrawer(context),
        body: Container(
          decoration: BoxDecoration(color: kPrimaryColor),
        ));
  }
}

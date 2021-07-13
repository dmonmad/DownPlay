import 'package:downplay/components/appBar.dart';
import 'package:downplay/components/downloads.dart';
import 'package:downplay/components/drawer.dart';
import 'package:downplay/consts.dart';
import 'package:downplay/providers/DownloadsProvider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

class DownloadsPage extends StatefulWidget {
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(context, 'Downloads'),
      body: Container(color: kPrimaryColor, child: DownloadsWidget()),
    );
  }
}

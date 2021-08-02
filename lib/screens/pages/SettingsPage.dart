import 'package:downplay/components/appBar.dart';
import 'package:downplay/components/drawer.dart';
import 'package:downplay/consts.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

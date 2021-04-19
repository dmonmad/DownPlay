import 'package:flutter/material.dart';
import 'package:downplay/consts.dart';
import 'package:downplay/components/videos_body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      drawer: buildDrawer(),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new ExactAssetImage('assets/pattern.jpg'),
                fit: BoxFit.fitWidth
              ),
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.music_video),
            title: Text('Video search'),
          ),
          ListTile(
            leading: Icon(Icons.video_collection),
            title: Text('Playlist'),
          ),
          ListTile(
            leading: Icon(Icons.file_download),
            title: Text('Downloads'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
    );
  }
}

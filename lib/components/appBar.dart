import 'package:downplay/consts.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String title) {
  return AppBar(    
    elevation: 2,
    centerTitle: true,
    title: Text(title, style: TextStyle(color: Colors.white),),
  );
}

/* Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: new ExactAssetImage('assets/pattern.jpg'),
                fit: BoxFit.fitWidth),
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
          leading: Icon(Icons.trending_up_outlined),
          title: Text('Trending'),
          onTap: () {},
        ),
        ListTile(
            leading: Icon(Icons.search),
            title: Text('Video search'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoSearchPage()));
            }),
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
  ); */

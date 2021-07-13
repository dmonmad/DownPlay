import 'package:downplay/consts.dart';
import 'package:downplay/screens/pages/DownloadsPage.dart';
import 'package:downplay/screens/pages/VideoSearchPage.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;

Drawer buildDrawer(BuildContext context) {
  return Drawer(
      elevation: 2,
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          children: [
            Container(
              child: ListTile(
                  leading: Icon(Icons.search,
                      color:
                          _selectedIndex == 0 ? kPrimaryColor : Colors.white),
                  title: Text('Video search',
                      style: TextStyle(
                          color: _selectedIndex == 0
                              ? kPrimaryColor
                              : Colors.white)),
                  selected: _selectedIndex == 0,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    _selectedIndex = 0;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoSearchPage()));
                  }),
            ),
            Container(
              child: ListTile(
                  leading: Icon(Icons.video_collection,
                      color:
                          _selectedIndex == 1 ? kPrimaryColor : Colors.white),
                  title: Text('Playlist',
                      style: TextStyle(
                          color: _selectedIndex == 1
                              ? kPrimaryColor
                              : Colors.white)),
                  selected: _selectedIndex == 1,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    _selectedIndex = 1;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoSearchPage()));
                  }),
            ),
            Container(
              child: ListTile(
                  leading: Icon(Icons.settings,
                      color:
                          _selectedIndex == 2 ? kPrimaryColor : Colors.white),
                  title: Text('Settings',
                      style: TextStyle(
                          color: _selectedIndex == 2
                              ? kPrimaryColor
                              : Colors.white)),
                  selected: _selectedIndex == 2,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    _selectedIndex = 2;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VideoSearchPage()));
                  }),
            ),
            Container(
              child: ListTile(
                  leading: Icon(Icons.download_rounded,
                      color:
                          _selectedIndex == 3 ? kPrimaryColor : Colors.white),
                  title: Text('Downloads',
                      style: TextStyle(
                          color: _selectedIndex == 3
                              ? kPrimaryColor
                              : Colors.white)),
                  selected: _selectedIndex == 3,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    _selectedIndex = 3;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DownloadsPage()));
                  }),
            ),
          ],
        ),
      ));
}

import 'package:downplay/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int _selectedIndex = 0;

Widget buildBottomBar(BuildContext context) {
  return Container(
    height: 55.0,
    child: BottomAppBar(

      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            child: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              _selectedIndex = 0;
            },
          ),
          IconButton(
            icon: Icon(Icons.video_collection, color: Colors.white),
            onPressed: () {
              _selectedIndex = 1;
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              _selectedIndex = 2;
            },
          )
        ],
      ),
    ),
  );
}

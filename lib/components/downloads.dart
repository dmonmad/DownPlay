import 'package:downplay/consts.dart';
import 'package:downplay/providers/DownloadsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadsWidget extends StatefulWidget {
  const DownloadsWidget({Key key}) : super(key: key);

  @override
  _DownloadsWidgetState createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  @override
  Widget build(BuildContext context) {
    DownloadsProvider downProvider = Provider.of<DownloadsProvider>(context);
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      downProvider.activeDownloads[index].video.title,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

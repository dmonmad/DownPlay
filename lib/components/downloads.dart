import 'dart:convert';

import 'package:downplay/consts.dart';
import 'package:downplay/providers/DownloadsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadsWidget extends StatefulWidget {
  const DownloadsWidget() : super();

  @override
  _DownloadsWidgetState createState() => _DownloadsWidgetState();
}

class _DownloadsWidgetState extends State<DownloadsWidget> {
  @override
  Widget build(BuildContext context) {
    DownloadsProvider downProvider =
        Provider.of<DownloadsProvider>(context);
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: downProvider.activeDownloads.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            kPrimaryColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [
                            downProvider.activeDownloads[index].progress,
                            100
                          ],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          downProvider.activeDownloads[index].video.title,
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

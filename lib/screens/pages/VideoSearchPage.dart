import 'dart:async';

import 'package:downplay/components/appBar.dart';
import 'package:downplay/components/drawer.dart';
import 'package:downplay/consts.dart';
import 'package:downplay/providers/DownloadsProvider.dart';
import 'package:downplay/providers/VideoProvider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:youtube_api/youtube_api.dart';

class VideoSearchPage extends StatefulWidget {
  @override
  _VideoSearchPageState createState() => _VideoSearchPageState();
}

class _VideoSearchPageState extends State<VideoSearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  YT_API selectedVideo;

  Timer _searcherFieldDebounce;
  TextEditingController _searchController;
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;

  List<YT_API> videos = [];
  bool _loadingVideos = false;
  int maxVideosToLoad = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, 'Video download'),
      drawer: buildDrawer(context),
      body: Container(
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSearchBar(context),
              _loadingVideos
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : videos.length > 0
                      ? Expanded(
                          child: Container(
                            child: ListView.builder(
                              // separatorBuilder: (context, index) => Divider(
                              //   color: Colors.black,
                              //   height: 15,
                              //   endIndent: 20,
                              //   indent: 20,
                              // ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 20,
                              itemBuilder: (BuildContext context, int index) {
                                YT_API video = videos[index];
                                return buildVideoTile(video);
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/no_results.png',
                                height: MediaQuery.of(context).size.width / 2,
                                width: MediaQuery.of(context).size.width / 2),
                            Text(
                              'No videos to show! Try searching something :)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )))
            ],
          ))),
    );
  }

  Widget buildVideoTile(YT_API video) {
    return Card(
      color: kPrimaryColor,
      child: GFListTile(
        title: Text(video.title, style: TextStyle(color: Colors.white)),
        avatar: Container(
            height: 90,
            width: 160,
            child: Image.network(getThumbnail(video.thumbnail))),
        icon: Icon(Icons.download_rounded, color: Colors.white),
        padding: EdgeInsets.zero,
        onTap: () {
          downloadVideo(video);
        },
      ),
    );
  }

  downloadVideo(YT_API video) async {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    DownloadsProvider downloadsProvider =
        Provider.of<DownloadsProvider>(context, listen: false);
    bool downloadResult = await downloadsProvider.startDownload(video, context);

    ScaffoldFeatureController controller;

    if (downloadResult) {
      controller = scaffoldMessenger.showSnackBar(
        SnackBar(
          content:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Icon(Icons.check, color: Colors.white),
            Text('Se ha descargado ${video.title}.mp3')
          ]),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      controller = scaffoldMessenger.showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.check, color: Colors.white),
                  Text('Hubo un error descargando ${video.title}')
                ])),
      );
    }
    await controller.closed;
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
            top: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
            left: kDefaultPadding / 2),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    _onSearchChanged(value);
                  },
                  onChanged: (value) {
                    _onSearchChanged(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: kPrimaryColor,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Darude - Sandstorm...',
                      hintStyle: TextStyle(color: Colors.white60)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadVideos(String query) async {
    setState(() {
      _loadingVideos = true;
    });

    List<YT_API> videosResult =
        await VideosProvider.instance.getMusic(query, maxVideosToLoad);

    setState(() {
      videos = videosResult;
      _loadingVideos = false;
    });
  }

  _onSearchChanged(String query) {
    if (_searcherFieldDebounce != null && _searcherFieldDebounce.isActive)
      _searcherFieldDebounce.cancel();
    if (query != "") {
      _searcherFieldDebounce =
          Timer(const Duration(milliseconds: SEARCH_DEBOUNCE_TIME), () {
        loadVideos(query);
      });
    } else {
      videos = [];
    }
  }

  getThumbnail(thumb) {
    return thumb['medium']['url'];
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_viewer/consts.dart';
import 'package:yt_viewer/logic.dart';
import 'package:yt_viewer/providers/videoprovider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  YT_API selectedVideo;
  YoutubePlayerController _ytcontroller;
  YoutubePlayerFlags flags = new YoutubePlayerFlags(
    autoPlay: false,
    mute: false,
  );

  Timer _searcherFieldDebounce;
  TextEditingController _searchController;
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory;
  String selectedTerm;

  List<YT_API> videos = [];
  bool _loadingVideos = false;

  loadVideos(query) async {
    setState(() {
      _loadingVideos = true;
    });

    List<YT_API> videosResult =
        await VideosProvider().getInstance().getMusic(query);

    setState(() {
      videos = videosResult;
      _loadingVideos = false;
    });
  }

  setVideo(YT_API video) {
    setState(() {
      this.selectedVideo = video;
      if (_ytcontroller != null) {
        _ytcontroller = null;
      }
      this._ytcontroller = new YoutubePlayerController(
          initialVideoId: video.id, flags: this.flags);
    });
  }

  downloadVideo(YT_API video){
    startDownload(video.url, context);
  }

  getThumbnail(thumb) {
    return thumb['medium']['url'];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searcherFieldDebounce?.cancel();
    _searchController.dispose();
    _ytcontroller.dispose();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_searcherFieldDebounce?.isActive ?? false)
      _searcherFieldDebounce.cancel();
    _searcherFieldDebounce =
        Timer(const Duration(milliseconds: SEARCH_DEBOUNCE_TIME), () {
      loadVideos(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        buildSearchBar(context),
        _loadingVideos
            ? Padding(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: CircularProgressIndicator(),
              )
            : videos.length > 0
                ? Expanded(
                    child: buildVideoList(),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: kDefaultPadding),
                    child: Text('Nada por aquí...'),
                  )
      ],
    ));
  }

  Padding buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kDefaultPadding / 2, right: kDefaultPadding / 2, left: kDefaultPadding / 2),
      child: Column(
        children: [
          Card(
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                _onSearchChanged(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search by video title',
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView buildVideoList() {
    return ListView.builder(
      itemCount: videos.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (videos.length == index) {
          return null;
        }
        var video = videos[index];
        return Container(
          color: Colors.white,
          child: Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setVideo(video);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image(
                          height: 90,
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(getThumbnail(video.thumbnail))),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(video.title),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                selectedVideo == video ? buildVideoOptions(video) : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildVideoOptions(YT_API video) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor)),
              onPressed: () {
                downloadVideo(video);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_rounded),
                ],
              )),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.open_in_new_rounded),
              ],
            ))
      ],
    );
  }

  Widget buildVideoView(YT_API video) {
    return YoutubePlayer(
      //controller: _ytcontroller,
      controller:
          new YoutubePlayerController(initialVideoId: video.id, flags: flags),
      showVideoProgressIndicator: true,
      progressColors: ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
    );
  }
}

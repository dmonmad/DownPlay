import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:youtube_api_v3/youtube_api_v3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber),
      title: 'Startup Name Generator',
      home: YoutubeVideos(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/* class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{}; // NEW
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair); // NEW
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }, // ... to here.
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
} */

class YoutubeVideos extends StatefulWidget {
  YoutubeVideos({Key key}) : super(key: key);

  @override
  _YoutubeVideosState createState() => _YoutubeVideosState();
}

class _YoutubeVideosState extends State<YoutubeVideos> {
  List<PlayListItem> videos = [];
  PlayListItemListResponse currentPage;

  @override
  void initState() {
    super.initState();
    getMusic();
  }

  setVideos(videos) {
    setState(() {
      this.videos = videos;
    });
  }

  Future<List<PlayListItem>> getMusic() async {
    YoutubeAPIv3 api = new YoutubeAPIv3('AIzaSyBS4JnxbqVpayCBeXCxG3zjE__Eja1uyLQ');

    PlayListItemListResponse playlist =
        await api.playListItems(playlistId: 'PLTfigAbxBUNpoZ1OspADCabQ5meRDmPlP', maxResults: 5, part: Parts.snippet);
    var videos = playlist.items.map((video) {
      return video;
    }).toList();
    currentPage = playlist;
    this.videos.addAll(videos);
    setVideos(this.videos);
  }

  Future<List<PlayListItem>> nextPage() async {
    PlayListItemListResponse playlist = await currentPage.nextPage();
    var videos = playlist.items.map((video) {
      return video;
    }).toList();
    currentPage = playlist;
    this.videos.addAll(videos);
    setVideos(this.videos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Link Getter'),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: videos.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (videos.length == index) {
            return ElevatedButton(
              onPressed: () {
                nextPage();
              },
              child: Text(
                'Load More',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          var video = videos[index];
          return Card(
              margin: EdgeInsets.all(20),
              child: Column(children: <Widget>[
                Text(video.snippet.title),
                Image(fit: BoxFit.fitWidth, image: NetworkImage(video.snippet.thumbnails.medium.url)),
              ]));
        },
      )),
    );
  }
}

class Video {
  final String thumbnail;

  Video(this.thumbnail);
}

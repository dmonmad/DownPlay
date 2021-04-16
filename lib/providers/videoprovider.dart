import 'package:youtube_api/youtube_api.dart';
import 'package:yt_viewer/consts.dart';

class VideosProvider {
  VideosProvider instance;

  getInstance() {
    if (instance == null) {
      instance = this;
    }
    return instance;
  }

  Future<List<YT_API>> getMusic(String query) async {
    YoutubeAPI api = new YoutubeAPI(
      YOUTUBE_API_KEY,
      type: 'video',
      maxResults: 15,
    );
    List<YT_API> videosResult = await api.search(query);
    return videosResult;
  }
}

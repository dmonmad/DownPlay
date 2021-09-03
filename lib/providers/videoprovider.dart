import 'package:youtube_api/youtube_api.dart';
import 'package:downplay/consts.dart';
import 'package:devicelocale/devicelocale.dart';

class VideosProvider {
  static final VideosProvider instance = VideosProvider._();
  VideosProvider._();

  Future<List<YouTubeVideo>> getMusic(String query, int maxResults) async {
    YoutubeAPI api = new YoutubeAPI(
      YOUTUBE_API_KEY,
      type: 'video',
      maxResults: maxResults,
    );
    List<YouTubeVideo> videosResult = await api.search(query);
    return videosResult;
  }

}

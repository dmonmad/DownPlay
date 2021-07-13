import 'package:youtube_api/youtube_api.dart';
import 'package:downplay/consts.dart';
import 'package:devicelocale/devicelocale.dart';

class VideosProvider {
  static final VideosProvider instance = VideosProvider._();
  VideosProvider._();

  Future<List<YT_API>> getMusic(String query, int maxResults) async {
    YoutubeAPI api = new YoutubeAPI(
      YOUTUBE_API_KEY,
      type: 'video',
      maxResults: maxResults,
    );
    List<YT_API> videosResult = await api.search(query);
    return videosResult;
  }

  Future<List<YT_API>> getTrending() async {
    YoutubeAPI api = new YoutubeAPI(
      YOUTUBE_API_KEY,
      type: 'video',
      maxResults: 15,
    );
    String locale = await Devicelocale.currentLocale;
    locale = locale.substring(3);
    print(locale);
    List<YT_API> videosResult = await api.getTrends(regionCode: locale);
    return videosResult;
  }
}

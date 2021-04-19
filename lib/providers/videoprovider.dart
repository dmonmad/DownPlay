import 'package:youtube_api/youtube_api.dart';
import 'package:downplay/consts.dart';
import 'package:devicelocale/devicelocale.dart';

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

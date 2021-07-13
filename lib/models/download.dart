import 'package:youtube_api/youtube_api.dart';

class Download {
  YT_API _video;

  YT_API get video => _video;

  set video(YT_API video) {
    _video = video;
  }

  double _progress;

  double get progress => _progress;

  set progress(double progress) {
    _progress = progress;
  }

  bool _success;

  bool get success => _success;

  set success(bool success) {
    _success = success;
  }

  bool _error;

  bool get error => _error;

  set error(bool error) {
    _error = error;
  }

  bool _inprogress;
  Download({
    YT_API video,
    double progress,
    bool success,
    bool error,
    bool inprogress,
  })  : _video = video,
        _progress = progress,
        _success = success,
        _error = error,
        _inprogress = inprogress;

  bool get inprogress => _inprogress;

  set inprogress(bool inprogress) {
    _inprogress = inprogress;
  }

  @override
  String toString() {
    return 'Download(video: $video, progress: $progress, success: $success, error: $error, inprogress: $inprogress)';
  }
}

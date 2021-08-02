import 'package:diacritic/diacritic.dart';
import 'package:downplay/models/download.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'dart:io';

class DownloadsProvider extends ChangeNotifier {
  final YoutubeExplode ytexp = YoutubeExplode();

  List<Download> activeDownloads = [];

  void addActiveDownload(Download download) {
    activeDownloads.add(download);
    notifyListeners();
  }

  void removeActiveDownload(Download download) {
    activeDownloads.remove(download);
    notifyListeners();
  }

  Future<bool> startDownload(YT_API video, BuildContext context) async {
    Download newDownload = new Download(video: video);
    addActiveDownload(newDownload);

    try {
      PermissionStatus storagePerm = await Permission.storage.request();
      if (!storagePerm.isGranted) {
        ScaffoldMessenger.maybeOf(context).showSnackBar(SnackBar(
            content: Text(
                'Debes dar acceso al almacenamiento para poder guardar el archivo')));
        return false;
      }

      video.url.trim();

      Video ytvideo = await ytexp.videos.get(video.url);
      Directory downloadDirectory =
          await DownloadsPathProvider.downloadsDirectory;
      Directory(downloadDirectory.path).createSync();
      StreamManifest manifest =
          await ytexp.videos.streamsClient.getManifest(video.url);
      Iterable<AudioOnlyStreamInfo> streams = manifest.audioOnly;
      AudioOnlyStreamInfo audio = streams.withHighestBitrate();
      Stream<List<int>> audioStream = ytexp.videos.streamsClient.get(audio);

      String fileName = '${ytvideo.title}.mp3'
          .replaceAll(r'\', '')
          .replaceAll('/', '')
          .replaceAll(':', '')
          .replaceAll('*', '')
          .replaceAll('?', '')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .replaceAll('<', '')
          .replaceAll('>', '')
          .replaceAll('^', '')
          .replaceAll(';', '')
          .replaceAll('|', '');

      fileName = removeDiacritics(fileName);

      File file = File('/storage/emulated/0/Download/$fileName');

      if (file.existsSync()) {
        file.deleteSync();
      }

      IOSink output = file.openWrite(mode: FileMode.writeOnlyAppend);

      double len = audio.size.totalBytes.toDouble();
      double count = 0;

      //String downloaderText = 'Descargando ${ytvideo.title}.mp3';

      await for (var data in audioStream) {
        // Keep track of the current downloaded data.
        count += data.length.toDouble();

        // Calculate the current progress.

        newDownload.progress = (count / len) / 1;
        // Update the progressbar.

        //logCallback(100, progress);

        // Write to file.
        output.add(data);
      }

      output.close();
      
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

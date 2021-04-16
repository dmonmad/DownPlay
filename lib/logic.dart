import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'dart:io';

final FlutterFFmpegConfig _flutterFFmpegConfig = new FlutterFFmpegConfig();
final YoutubeExplode ytexp = YoutubeExplode();

double statistics = 0.0;
String downloaderText = '';

void logCallback(int level, double message) {
  statistics = message;
}

reset() {
  statistics = 0.0;
  downloaderText = '';
}

startDownload(url, context) async {
  reset();
  PermissionStatus storagePerm = await Permission.storage.request();
  if (!storagePerm.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Debes dar acceso al almacenamiento para guardar el archivo')));
    return;
  }

  url.trim();
  print(url);

  Video ytvideo = await ytexp.videos.get(url);
  print('El video title es ' + ytvideo.title);
  print('El video id es ' + ytvideo.id.toString());

  Directory downloadDirectory = await DownloadsPathProvider.downloadsDirectory;
  Directory(downloadDirectory.path).createSync();
  print(downloadDirectory.path);

  StreamManifest manifest = await ytexp.videos.streamsClient.getManifest(url);
  Iterable<AudioOnlyStreamInfo> streams = manifest.audioOnly;

  AudioOnlyStreamInfo audio = streams.withHighestBitrate();
  Stream<List<int>> audioStream = ytexp.videos.streamsClient.get(audio);

  //String fileName = '${ytvideo.title}.${audio.container.name.toString()}'
  
  print(ytvideo.title);
  String fileName = '${ytvideo.title}.mp3'
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll(' ', '')
      .replaceAll('|', '');

  print('fileName= ' + fileName);
  File file = File('/storage/emulated/0/Download/$fileName');

  print('file= ' + file.path);
  if (file.existsSync()) {
    file.deleteSync();
  }

  IOSink output = file.openWrite(mode: FileMode.writeOnlyAppend);

  double len = audio.size.totalBytes.toDouble();
  double count = 0;

  downloaderText = 'Descargando ${ytvideo.title}.mp3';

  await for (var data in audioStream) {
    // Keep track of the current downloaded data.
    count += data.length.toDouble();

    // Calculate the current progress.

    double progress = ((count / len) / 1);
    // Update the progressbar.
    logCallback(100, progress);

    // Write to file.
    output.add(data);
  }
  output.close();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Se ha descargado ${downloaderText}')));
}

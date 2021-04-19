import 'package:flutter/material.dart';
import 'package:downplay/app_state.dart';

const String SplashPath = '/splash';
const String SearchPath = '/search';
const String PlaylistPath = '/playlist';
const String DownloadsPath = '/downloads';
const String SettingsPath = '/settings';

enum Pages { Splash, Search, Playlist, Downloads, Settings }

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  PageAction currentPageAction;

  PageConfiguration(
      {@required this.key,
      @required this.path,
      @required this.uiPage,
      this.currentPageAction});  
}

PageConfiguration SplashPageConfig = PageConfiguration(
      key: 'Splash',
      path: SplashPath,
      uiPage: Pages.Splash,
      currentPageAction: null);
  PageConfiguration SearchPageConfig = PageConfiguration(
      key: 'Search',
      path: SearchPath,
      uiPage: Pages.Search,
      currentPageAction: null);
  PageConfiguration PlaylistPageConfig = PageConfiguration(
      key: 'Playlist',
      path: PlaylistPath,
      uiPage: Pages.Playlist,
      currentPageAction: null);
  PageConfiguration DownloadsPageConfig = PageConfiguration(
    key: 'Downloads',
    path: DownloadsPath,
    uiPage: Pages.Downloads);
  PageConfiguration SettingsPageConfig = PageConfiguration(
      key: 'Settings',
      path: SettingsPath,
      uiPage: Pages.Settings,
      currentPageAction: null);

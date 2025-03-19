import 'package:flutter/material.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/pages/comunity/comunity_masjid_page.dart';
import 'package:masjid_korea/pages/detail/detail_page.dart';
import 'package:masjid_korea/pages/error/error_page.dart';
import 'package:masjid_korea/pages/gallery/gallery_page.dart';
import 'package:masjid_korea/pages/homepage/homepage.dart';
import 'package:masjid_korea/pages/search/search_page.dart';
import 'package:masjid_korea/pages/splashpage/splash_page.dart';

class AppRoutes {
  final MasjidModel masjid;
  AppRoutes(this.masjid);

  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => SplashPage(),
      '/homepage':
          (context) => Homepage(rekomendasiMasjid: [], comunityMasjid: []),
      '/comunity': (context) => CommunityMasjidPage(masjid.comunity),
      '/detail': (context) => DetailPage(masjid: masjid),
      '/error': (context) => ErrorPage(),
      '/gallery': (context) => GalleryPage(masjid),
      '/search': (context) => SearchPage(),
    };
  }
}

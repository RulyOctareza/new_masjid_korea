import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/comunity/comunity_masjid_page.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_page.dart';
import 'package:masjid_korea/presentation/pages/error/error_page.dart';
import 'package:masjid_korea/presentation/pages/gallery/gallery_page.dart';
import 'package:masjid_korea/presentation/pages/homepage/homepage.dart';
import 'package:masjid_korea/presentation/pages/search/search_page.dart';
import 'package:masjid_korea/presentation/pages/splashpage/splash_page.dart';

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
      // Fix: gunakan masjid.comunity untuk halaman komunitas
      '/gallery': (context) => GalleryPage(masjid),
      '/search': (context) => SearchPage(),
    };
  }
}

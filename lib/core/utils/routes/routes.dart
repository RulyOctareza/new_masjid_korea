import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/admin_login_page.dart';
import 'package:masjid_korea/presentation/pages/comunity/comunity_masjid_page.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_page.dart';
import 'package:masjid_korea/presentation/pages/error/error_page.dart';
import 'package:masjid_korea/presentation/pages/gallery/gallery_page.dart';
import 'package:masjid_korea/presentation/pages/homepage/homepage.dart';
import 'package:masjid_korea/presentation/pages/search/search_page.dart';
import 'package:masjid_korea/presentation/pages/splashpage/splash_page.dart';
import 'package:masjid_korea/presentation/pages/admin_dashboard_page.dart';

class AppRoutes {
  final MasjidModel masjid;
  AppRoutes(this.masjid);

  /// Builder route clean, scalable, dan mudah maintain
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => SplashPage(),
      '/homepage': (context) => Homepage(rekomendasiMasjid: [], comunityMasjid: []),
      // Fix: gunakan masjid.comunity untuk halaman komunitas
      '/comunity': (context) => CommunityMasjidPage(masjid.comunity),
      '/detail': (context) => DetailPage(masjid: masjid),
      '/error': (context) => ErrorPage(),
      '/gallery': (context) => GalleryPage(masjid),
      '/search': (context) => SearchPage(),
      '/admin_login': (context) => const AdminLoginPage(),
      '/admin_dashboard': (context) => const AdminDashboardPage(),
      // Tambahkan route lain jika dibutuhkan
    };
  }
}

// routes/app_router.dart
// Tujuan: Mendefinisikan GoRouter untuk routing modern dan URL yang bersih.
// Cara pakai: Panggil buildRouter() di main.dart untuk MaterialApp.router.
// Catatan: Saat ini file belum diintegrasikan agar tidak mengubah perilaku aplikasi yang berjalan.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

// Placeholder imports (sementara gunakan halaman legacy untuk menjaga kompatibilitas visual)
import 'package:masjid_korea/presentation/pages/splashpage/splash_page.dart';
import 'package:masjid_korea/presentation/pages/search/search_page.dart' as legacy_search;

// Home baru
import 'package:masjid_korea/features/home/home_page.dart';
// Map baru
import 'package:masjid_korea/features/search/search_map_page.dart';
// Cubit/model
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:masjid_korea/features/mosque/mosque_detail_page.dart';

GoRouter buildRouter(GlobalKey<NavigatorState> key) {
  return GoRouter(
    navigatorKey: key,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          final community = state.uri.queryParameters['community'];
          return HomePage(
            initialCommunity: (community != null && community.isNotEmpty) ? community : null,
          );
        },
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) {
          // Terapkan query params untuk filters (kota, radius, q) dan tampilan peta
          final qp = state.uri.queryParameters;
          final view = qp['view'];

          // Hanya gunakan SearchMapPage saat diminta view=map
          if (view == 'map') {
            final city = qp['city']?.trim();
            final q = qp['q']?.trim();
            final lat = double.tryParse(qp['lat'] ?? '');
            final lon = double.tryParse(qp['lon'] ?? '');
            final radiusKm = double.tryParse(qp['radius'] ?? '');

            return SearchMapPage(
              showMap: true,
              city: (city != null && city.isNotEmpty) ? city : null,
              q: (q != null && q.isNotEmpty) ? q : null,
              center: (lat != null && lon != null) ? LatLng(lat, lon) : null,
              radiusKm: radiusKm,
            );
          }
          // Kirimkan initialQuery ke halaman list pencarian
          final q = qp['q'];
          return legacy_search.SearchPage(initialQuery: q);
        },
      ),

      // Detail masjid (fitur baru)
      GoRoute(
        path: '/mosques/:id',
        name: 'mosque_detail',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          if (id == null || id.isEmpty) {
            final l10n = AppLocalizations.of(context);
            return Scaffold(
              body: Center(child: Text(l10n.invalidMosqueId)),
            );
          }
          return BlocBuilder<MasjidCubit, MasjidState>(
            builder: (context, s) {
              if (s is MasjidSuccess) {
                final m = s.masjid.firstWhere(
                  (e) => e.id == id,
                  orElse: () => const MasjidModel(id: ''),
                );
                if (m.id.isEmpty) {
                  final l10n = AppLocalizations.of(context);
                  return Scaffold(body: Center(child: Text(l10n.mosqueNotFound)));
                }
                return MosqueDetailPage(masjid: m);
              }
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          );
        },
      ),

      // Gallery placeholder (TODO)
      GoRoute(
        path: '/gallery',
        name: 'gallery',
        builder: (context, state) {
          final l10n = AppLocalizations.of(context);
          return Scaffold(
            body: Center(child: Text(l10n.galleryTodoPlaceholder)),
          );
        },
      ),
      // TODO(/contribute): dialog kontribusi akan dipush sebagai route/dialog
    ],
    errorBuilder: (context, state) {
      final l10n = AppLocalizations.of(context);
      return Scaffold(
        body: Center(
          child: Text(l10n.pageNotFound('${state.error}')),
        ),
      );
    },
    routerNeglect: true,
    debugLogDiagnostics: false,
  );
}
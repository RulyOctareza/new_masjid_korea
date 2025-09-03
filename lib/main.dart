import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/presentation/cubit/theme_masjid.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/utils/routes/routes.dart';
import 'package:masjid_korea/core/theme/theme.dart';

import 'firebase_options.dart';

/// Inisialisasi Firebase dengan error handling
Future<void> _initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }
}

/// Entry point utama aplikasi Masjid Korea
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  runApp(MyApp());
}

/// Root widget aplikasi, mengatur theme dan routing
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MasjidModel defaultMasjid = MasjidModel(
    id: '1',
    name: 'Masjid Al-Ishlah',
    location: 'Gwangju',
    city: 'Gwangju',
    address: 'Gwangju, South Korea',
    imageUrl: '',
    rating: 0.0,
    photos: [],
    comunity: 'default',
    latitude: 0.0,
    longitude: 0.0,
  );

  /// Global navigator key untuk kebutuhan navigasi universal
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Konfigurasi MaterialApp agar mudah di-maintain dan scalable
  Widget _buildMaterialApp(ThemeMode themeMode) {
    final appRoutes = AppRoutes(defaultMasjid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: appRoutes.getRoutes(),
      navigatorKey: _navigatorKey, // Untuk kebutuhan navigasi global
      // TODO: Tambahkan localization, dll jika dibutuhkan
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MasjidCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          // Builder untuk theme dan routing
          return _buildMaterialApp(themeMode);
        },
      ),
    );
  }
}

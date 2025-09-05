import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/presentation/cubit/theme_masjid.dart';
import 'package:masjid_korea/routes/app_router.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:masjid_korea/presentation/cubit/locale_cubit.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

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

  /// Global navigator key untuk kebutuhan navigasi universal
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Konfigurasi MaterialApp dengan GoRouter agar URL dan navigasi modern
  Widget _buildMaterialApp(ThemeMode themeMode, Locale locale) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: buildRouter(_navigatorKey),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MasjidCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          // Builder untuk theme dan routing
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return _buildMaterialApp(themeMode, locale);
            },
          );
        },
      ),
    );
  }
}

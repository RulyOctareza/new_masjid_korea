import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/cubit/masjid_cubit.dart';
import 'package:masjid_korea/cubit/theme_masjid.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/routes/routes.dart';
import 'package:masjid_korea/styles/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MasjidModel defaultMasjid = MasjidModel(
    id: '1',
    name: 'Masjid Al-Ishlah',
    location: 'Gwangju',
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MasjidCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final appRoutes = AppRoutes(defaultMasjid);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            initialRoute: '/',
            routes: appRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}

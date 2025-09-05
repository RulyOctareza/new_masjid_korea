import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/theme_masjid.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

/// Tombol toggle tema (light/dark) dengan aksesibilitas yang baik.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        final l10n = AppLocalizations.of(context);
        return Semantics(
          button: true,
          label: l10n.themeToggleLabel,
          hint: isDark ? l10n.themeToggleHintDark : l10n.themeToggleHintLight,
          child: IconButton(
            tooltip: l10n.themeToggleTooltip,
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/locale_cubit.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

/// LanguageSwitcher sederhana: menampilkan menu untuk memilih bahasa.
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Semantics(
          button: true,
          label: l10n.changeLanguageLabel,
          hint: l10n.chooseLanguageHint,
          child: PopupMenuButton<Locale>(
            tooltip: l10n.languageSwitcherTooltip,
            icon: const Icon(Icons.language),
            onSelected: (l) => context.read<LocaleCubit>().setLocale(l),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: const Locale('id'), child: Text(l10n.languageIndonesian)),
                PopupMenuItem(value: const Locale('en'), child: Text(l10n.languageEnglish)),
                PopupMenuItem(value: const Locale('ko'), child: Text(l10n.languageKorean)),
              ];
            },
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class SearchpageHeader extends StatelessWidget {
  const SearchpageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/images/masjid.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.searchWelcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.searchWelcomeSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 16.toDouble(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: Text(l10n.searchStartCta)),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:masjid_korea/features/mosque/widgets/mosque_card.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class DaftarMasjid extends StatelessWidget {
  final List<MasjidModel> masjids;
  final bool isSearching;

  const DaftarMasjid({
    super.key,
    required this.masjids,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: edge, top: edge),
              child: Text(
                isSearching
                    ? AppLocalizations.of(context).searchResultsTitle
                    : AppLocalizations.of(context).mosqueListKoreaTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: masjids.map((MasjidModel masjid) {
                return Column(
                  children: [
                    MosqueCard(
                      masjid: masjid,
                      onTap: () => context.push('/mosques/${masjid.id}'),
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

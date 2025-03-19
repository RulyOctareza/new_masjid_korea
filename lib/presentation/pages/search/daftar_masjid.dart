import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:masjid_korea/presentation/widgets/card/masjid_card.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: edge, top: edge),
          child: Text(
            isSearching ? 'Hasil Pencarian' : 'Daftar Masjid di Korea Selatan',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children:
              masjids.map((MasjidModel masjid) {
                return Column(
                  children: [MasjidCard(masjid), const SizedBox(height: 10)],
                );
              }).toList(),
        ),
      ],
    );
  }
}

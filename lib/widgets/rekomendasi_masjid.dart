import 'package:flutter/material.dart';
import 'package:masjid_korea/extensions/navigator_extensions.dart';

import 'package:masjid_korea/widgets/card/masjid_card.dart';

import '../models/remote/masjid_model.dart';
import '../styles/theme.dart';

class RekomendasiMasjid extends StatelessWidget {
  final List<MasjidModel> masjid;

  const RekomendasiMasjid({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    List<MasjidModel> shuffledMasjid = List.from(masjid);
    shuffledMasjid.shuffle();
    List<MasjidModel> displayedMasjid =
        shuffledMasjid.length > 5
            ? shuffledMasjid.sublist(0, 5)
            : shuffledMasjid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: edge, top: edge),
          child: Text(
            'Rekomendasi Masjid ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children:
              displayedMasjid.map((masjid) {
                return InkWell(
                  onTap: () => context.navigateTo('/detail'),
                  child: MasjidCard(masjid),
                );
              }).toList(),
        ),
      ],
    );
  }
}

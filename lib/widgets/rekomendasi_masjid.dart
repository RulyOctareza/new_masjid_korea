import 'package:flutter/material.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/styles/theme.dart';
import 'package:masjid_korea/widgets/card/masjid_card.dart';

class RekomendasiMasjid extends StatelessWidget {
  final List<MasjidModel> masjid;

  const RekomendasiMasjid({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    List<MasjidModel> shuffledMasjid = List.from(masjid);
    shuffledMasjid.shuffle();
    List<MasjidModel> displayedMasjid =
        shuffledMasjid.length > 5 ? masjid.sublist(0, 5) : masjid;

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
                return Column(children: [MasjidCard(masjid)]);
              }).toList(),
        ),
      ],
    );
  }
}

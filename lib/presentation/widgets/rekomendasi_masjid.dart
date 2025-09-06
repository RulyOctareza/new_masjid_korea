import 'package:flutter/material.dart';

// Removed legacy detail page import; MasjidCard handles navigation
import 'package:masjid_korea/features/mosque/widgets/mosque_card.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/remote/masjid_model.dart';
import '../../core/theme/theme.dart';

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
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: displayedMasjid
                  .map((m) => MosqueCard(
                        masjid: m,
                        onTap: () => context.push('/mosques/${m.id}'),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

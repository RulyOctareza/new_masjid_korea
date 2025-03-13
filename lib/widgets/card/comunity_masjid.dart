import 'package:flutter/material.dart';
import 'package:masjid_korea/extensions/text_extensions.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/styles/theme.dart';
import 'package:masjid_korea/widgets/comunity_masjid_card.dart';

class ComunityMasjid extends StatelessWidget {
  final List<MasjidModel> masjid;
  const ComunityMasjid({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: edge),
            child: Text(
              'Community of Mosque',
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView(
              padding: const EdgeInsets.only(left: 5),
              children: [
                SizedBox(
                  height: 175,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const SizedBox(width: 15),
                          KomunitasMasjid(
                            communityName: 'FKMID',
                            imageUrl: 'assets/FKMID.jpg',
                          ),
                          KomunitasMasjid(
                            communityName: 'FKMWU',
                            imageUrl: 'assets/FKMWU.jpg',
                          ),
                          KomunitasMasjid(
                            communityName: 'KMJJ',
                            imageUrl: 'assets/KMJJ.jpg',
                          ),
                          KomunitasMasjid(
                            communityName: 'MITRA PUMITA',
                            imageUrl: 'assets/MITRAPUMITA.jpg',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

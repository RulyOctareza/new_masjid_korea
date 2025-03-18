import 'package:flutter/material.dart';
import 'package:masjid_korea/extensions/text_extensions.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/service/map_utils.dart';
import 'package:masjid_korea/styles/theme.dart';

class DetailLocation extends StatelessWidget {
  final MasjidModel masjid;

  const DetailLocation({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            'Location',
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16.toDouble(),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(masjid.location, style: greyTextStyle),
              ),
              GestureDetector(
                onTap: () async {
                  await MapUtils().openKakaoMap(masjid.address);
                },
                child: const Icon(Icons.map_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

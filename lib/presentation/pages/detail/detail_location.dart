import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/network/service/map_utils.dart';
import 'package:masjid_korea/core/theme/theme.dart';

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
            children: [
              SizedBox(
                width: 200,
                child: Text(masjid.location, style: greyTextStyle),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: masjid.location));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      padding: EdgeInsets.all(8),
                      backgroundColor: Colors.green,
                      content: Text('Location copied to clipboard!'),
                    ),
                  );
                },
                child: const Icon(Icons.copy),
              ),
              const SizedBox(width: 35),
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

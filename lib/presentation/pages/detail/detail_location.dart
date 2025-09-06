import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/network/service/map_utils.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class DetailLocation extends StatelessWidget {
  final MasjidModel masjid;

  const DetailLocation({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            l10n.locationLabel,
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
              Tooltip(
                message: l10n.copyLocationTooltip,
                child: Semantics(
                  button: true,
                  label: l10n.copyLocationTooltip,
                  child: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: masjid.location));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.green,
                          content: Text(l10n.locationCopiedMessage),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 35),
              Tooltip(
                message: l10n.openMapTooltip,
                child: Semantics(
                  button: true,
                  label: l10n.openMapTooltip,
                  child: IconButton(
                    icon: const Icon(Icons.map_rounded),
                    onPressed: () async {
                      if (masjid.address.trim().isEmpty) {
                        return;
                      }
                      await MapUtils().openKakaoMap(masjid.address);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

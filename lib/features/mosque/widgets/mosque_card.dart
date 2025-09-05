// features/mosque/widgets/mosque_card.dart
// Tujuan: Kartu Masjid reusable untuk grid/list; menampilkan gambar, nama, kota, jarak opsional, dan badge Verified.
// Cara pakai: Gunakan di grid/list; integrasikan navigasi detail via onTap.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../data/models/remote/masjid_model.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class MosqueCard extends StatelessWidget {
  final MasjidModel masjid;
  final VoidCallback? onTap;
  final double? distanceKm; // opsional, jika geolokasi tersedia
  final bool isVerified; // TODO: map dari sumber data sesungguhnya

  const MosqueCard({
    super.key,
    required this.masjid,
    this.onTap,
    this.distanceKm,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: AppLocalizations.of(context).mosqueCardLabel(
        masjid.name.isEmpty ? AppLocalizations.of(context).nameUnavailable : masjid.name,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: SizedBox(
                  width: 140,
                  child: _Thumbnail(url: masjid.imageUrl),
                ),
              ),
              // Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              masjid.name.isEmpty
                                  ? AppLocalizations.of(context).nameUnavailable
                                  : masjid.name,
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isVerified)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified, size: 16, color: theme.colorScheme.primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    AppLocalizations.of(context).verified,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.place, size: 16, color: theme.hintColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              masjid.city.isEmpty
                                  ? AppLocalizations.of(context).cityUnavailable
                                  : masjid.city,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (distanceKm != null) ...[
                            const SizedBox(width: 8),
                            Icon(Icons.directions_walk, size: 16, color: theme.hintColor),
                            const SizedBox(width: 4),
                            Text(
                              '${distanceKm!.toStringAsFixed(1)} km',
                              style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String url;
  const _Thumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (url.isEmpty) {
      return Container(
        color: theme.colorScheme.surfaceContainerLow,
        child: Icon(Icons.image_not_supported, color: theme.hintColor),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, _) => Container(color: theme.colorScheme.surfaceContainerLow),
      errorWidget: (context, _, __) => Container(
        color: theme.colorScheme.surfaceContainerLow,
        child: Icon(Icons.broken_image, color: theme.hintColor),
      ),
    );
  }
}
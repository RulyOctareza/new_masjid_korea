import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/usecases/distance_calculate.dart';
import 'package:masjid_korea/core/usecases/location_service.dart';
import 'package:masjid_korea/core/network/service/masjid_sorting_service.dart';
import 'package:masjid_korea/features/mosque/widgets/mosque_card.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:masjid_korea/widgets/skeleton.dart';

class MasjidTerdekat extends StatefulWidget {
  final List<MasjidModel> masjids;

  const MasjidTerdekat({required this.masjids, super.key});

  @override
  State<MasjidTerdekat> createState() => _MasjidTerdekatState();
}

class _MasjidTerdekatState extends State<MasjidTerdekat> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    // Request location immediately and rebuild after permission dialog closes
    Future.microtask(() async {
      await _locationService.getLocation();
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_locationService.locationServiceEnabled ||
        !_locationService.permissionGranted) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.pleaseAllowLocationMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    await _locationService.getLocation();
                    if (mounted) setState(() {});
                  },
                  label: Text(l10n.tryAgainLabel),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Saat menunggu lokasi tersedia, jangan tampilkan layar kosong.
    // Tampilkan header section dan indikator progress kecil sebagai fallback konten.
    if (_locationService.currentPosition == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.mosquesClosestToYouLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 8),
                Text('Mencari lokasi…'),
              ],
            ),
            const SizedBox(height: 12),
            // Skeleton placeholder sebagai gambaran card yang akan muncul
            const SkeletonBox(width: double.infinity, height: 110),
            const SizedBox(height: 12),
            const SkeletonBox(width: double.infinity, height: 110),
          ],
        ),
      );
    }

    // Hitung dan urutkan; lindungi dari potensi error agar tidak memutus build
    List<MasjidModel> nearbyMasjids = const <MasjidModel>[];
    try {
      nearbyMasjids = MasjidSortingService.sortMasjidsByDistance(
        _locationService.currentPosition,
        widget.masjids,
      );
    } catch (_) {
      nearbyMasjids = const <MasjidModel>[];
    }

    if (nearbyMasjids.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.mosquesClosestToYouLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noData,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            l10n.mosquesClosestToYouLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ...nearbyMasjids.map((masjid) {
          double distance;
          try {
            distance = calculateDistance(
              _locationService.currentPosition!.latitude,
              _locationService.currentPosition!.longitude,
              masjid.latitude,
              masjid.longitude,
            );
          } catch (_) {
            distance = double.nan;
          }

          final passableDistance =
              distance.isFinite && !distance.isNaN ? distance : null;

          return MosqueCard(
            masjid: masjid,
            distanceKm: passableDistance,
            onTap: () {
              // Navigasi konsisten ke halaman detail baru
              // ignore: use_build_context_synchronously
              context.push('/mosques/${masjid.id}');
            },
          );
        }),
      ],
    );
  }
}

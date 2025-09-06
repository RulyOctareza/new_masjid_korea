// features/mosque/mosque_detail_page.dart
// Halaman detail masjid (versi baru) dengan Material 3, responsif, dan aksesibilitas.
// Fitur: Carousel foto, informasi lokasi, tombol "Buka di Maps", dan stub PrayerTimesWidget.

import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/network/service/map_utils.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:adhan_dart/adhan_dart.dart';

class MosqueDetailPage extends StatefulWidget {
  final MasjidModel masjid;
  const MosqueDetailPage({super.key, required this.masjid});

  @override
  State<MosqueDetailPage> createState() => _MosqueDetailPageState();
}

class _MosqueDetailPageState extends State<MosqueDetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = widget.masjid;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(m.name.isEmpty ? l10n.mosqueDetailTitle : m.name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HeaderCarousel(
              photos: m.photos.isNotEmpty ? m.photos.cast<String>() : [m.imageUrl],
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul + Kota
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.name.isEmpty ? l10n.nameUnavailable : m.name,
                              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.place, size: 18),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    m.city.isEmpty ? l10n.cityUnavailable : m.city,
                                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_photoCount(m) > 1)
                        _DotIndicators(count: _photoCount(m), current: _currentPage),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Info lokasi/alamat
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.colorScheme.outlineVariant)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.addressLabel, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.map, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  // Tampilkan alamat asli (huruf Korea) dari Firebase di field `location`
                                  m.location.isNotEmpty
                                      ? m.location
                                      : (m.address.isNotEmpty ? m.address : l10n.addressUnavailable),
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          // Hapus tombol inline agar fokus pada FAB melayang
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stub Jadwal Sholat
                  PrayerTimesCard(masjid: m),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      // Tombol "Buka di Maps" sebagai floating action button melayang
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            // Tetap gunakan alamat URL/kata kunci dari field address untuk membuka peta (Kakao)
            await MapUtils().openKakaoMap(m.address.isNotEmpty ? m.address : m.location);
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.failedOpenMap('$e'))),
            );
          }
        },
        icon: const Icon(Icons.map),
        label: Text(l10n.openInMaps),
      ),
    );
  }

  int _photoCount(MasjidModel m) {
    final list = m.photos.cast<String>();
    if (list.isNotEmpty) return list.length;
    return m.imageUrl.isNotEmpty ? 1 : 0;
  }
}

class _HeaderCarousel extends StatelessWidget {
  final List<String> photos;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const _HeaderCarousel({
    required this.photos,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = photos.where((e) => e.isNotEmpty).toList();

    if (list.isEmpty) {
      return AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: theme.colorScheme.surfaceContainerHigh,
          child: Icon(Icons.image_not_supported, color: theme.hintColor),
        ),
      );
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: ScrollConfiguration(
            behavior: const _AppScrollBehavior(),
            child: PageView.builder(
              controller: controller,
              onPageChanged: onPageChanged,
              itemCount: list.length,
              itemBuilder: (_, i) {
                final url = list[i];
                return Semantics(
                  image: true,
                  label: AppLocalizations.of(context).photoSemantics(i, list.length),
                  child: Image.network(url, fit: BoxFit.cover),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

class _DotIndicators extends StatelessWidget {
  final int count;
  final int current;
  const _DotIndicators({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (i) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == current ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}

class PrayerTimesCard extends StatelessWidget {
  final MasjidModel masjid;
  const PrayerTimesCard({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final lat = masjid.latitude;
    final lon = masjid.longitude;

    // Jika koordinat belum tersedia, tampilkan placeholder yang ramah
    if (lat == 0.0 && lon == 0.0) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.prayerTimesTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(l10n.prayerTimesMessage, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }

    // Hitung jadwal sholat menggunakan MWL + Shafi
    final coords = Coordinates(lat, lon);
    final params = CalculationMethod.muslimWorldLeague();
    params.madhab = Madhab.shafi;

    // Paksa zona waktu Korea (KST, GMT+9) untuk tanggal perhitungan dan tampilan
    const kstOffset = Duration(hours: 9);
    final nowKst = DateTime.now().toUtc().add(kstOffset);

    final pt = PrayerTimes(
      coordinates: coords,
      date: nowKst,
      calculationParameters: params,
    );

    DateTime _toKst(DateTime dt) => dt.toUtc().add(kstOffset);
    // Format 24-jam sesuai permintaan (HH:mm)
    String fmt(DateTime? dt) => dt == null ? '-' : DateFormat('HH:mm').format(_toKst(dt));

    final rows = <_PrayerRow>[
      _PrayerRow(label: l10n.fajrLabel, time: fmt(pt.fajr)),
      _PrayerRow(label: l10n.sunriseLabel, time: fmt(pt.sunrise)),
      _PrayerRow(label: l10n.dhuhrLabel, time: fmt(pt.dhuhr)),
      _PrayerRow(label: l10n.asrLabel, time: fmt(pt.asr)),
      _PrayerRow(label: l10n.maghribLabel, time: fmt(pt.maghrib)),
      _PrayerRow(label: l10n.ishaLabel, time: fmt(pt.isha)),
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan label zona waktu KST (GMT+9)
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.prayerTimesTitle,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Text(
                    l10n.timeZoneKstGmt9,
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: rows
                  .map((r) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(r.label, style: theme.textTheme.bodyMedium),
                            ),
                            Text(r.time, style: theme.textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.prayerTimesMessage,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerRow {
  final String label;
  final String time;
  _PrayerRow({required this.label, required this.time});
}
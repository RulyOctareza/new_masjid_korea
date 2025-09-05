// features/mosque/mosque_detail_page.dart
// Halaman detail masjid (versi baru) dengan Material 3, responsif, dan aksesibilitas.
// Fitur: Carousel foto, informasi lokasi, tombol "Buka di Maps", dan stub PrayerTimesWidget.

import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/network/service/map_utils.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';

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
                                  m.address.isEmpty ? l10n.addressUnavailable : m.address,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FilledButton.icon(
                              onPressed: () async {
                                try {
                                  await MapUtils().openKakaoMap(m.address);
                                } catch (e) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(l10n.failedOpenMap('$e'))),
                                  );
                                }
                              },
                              icon: const Icon(Icons.navigation),
                              label: Text(l10n.openInMaps),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stub Jadwal Sholat
                  const _PrayerTimesStub(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
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

class _PrayerTimesStub extends StatelessWidget {
  const _PrayerTimesStub();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: theme.colorScheme.outlineVariant)),
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
}
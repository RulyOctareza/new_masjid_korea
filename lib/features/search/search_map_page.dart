// features/search/search_map_page.dart
// Halaman peta pencarian masjid dengan pola:
// - Mobile: tab (Daftar, Peta) — default ke Peta jika datang dari view=map
// - Tablet/Desktop: split view (panel daftar di kiri, peta di kanan)
// Integrasi flutter_map + marker, binding filter/query params (sebagian)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;

import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/usecases/location_service.dart';
import 'package:masjid_korea/core/usecases/distance_calculate.dart';
import 'package:masjid_korea/widgets/empty_state.dart';
import 'package:masjid_korea/widgets/error_state.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class SearchMapPage extends StatefulWidget {
  final bool showMap;
  // Query/filter opsional dari URL
  final String? city;
  final String? q; // kata kunci bebas
  final LatLng? center; // pusat peta awal override
  final double? radiusKm; // jika center ada, filter dalam radius km

  const SearchMapPage({
    super.key,
    this.showMap = true,
    this.city,
    this.q,
    this.center,
    this.radiusKm,
  });

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  int _tabIndex = 1; // 0: List, 1: Map
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();
  bool _locating = false;

  // Seoul sebagai default center
  static const LatLng _defaultCenter = LatLng(37.5665, 126.9780);

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.showMap ? 1 : 0;

    // Pastikan data masjid terambil saat halaman ini dibuka langsung (deep link)
    final state = context.read<MasjidCubit>().state;
    if (state is! MasjidSuccess && state is! MasjidLoading) {
      context.read<MasjidCubit>().fetchMasjid();
    }
  }

  Future<void> _useMyLocation() async {
    setState(() => _locating = true);
    try {
      await _locationService.getLocation();
      final pos = _locationService.currentPosition;
      if (pos != null) {
        final target = LatLng(pos.latitude, pos.longitude);
        _mapController.move(target, 13);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).locationCenteredMsg)),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).locationPermissionError)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).locationFailedMessage('$e'))),
        );
      }
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isDesktop = width >= 1024;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.searchTitle),
        ),
        body: IndexedStack(
          index: _tabIndex,
          children: [
            listPlaceholder(context),
            mapPanel(
              context,
              _mapController,
              _locating,
              _useMyLocation,
              _defaultCenter,
              widget.center,
              widget.radiusKm,
              widget.city,
              widget.q,
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tabIndex,
          onDestinationSelected: (value) => setState(() => _tabIndex = value),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.list_alt_outlined), selectedIcon: const Icon(Icons.list_alt), label: l10n.listTabLabel),
            NavigationDestination(icon: const Icon(Icons.map_outlined), selectedIcon: const Icon(Icons.map), label: l10n.mapTabLabel),
          ],
        ),
      );
    }

    // Tablet/Desktop — split view
    final sideWidth = isDesktop ? 420.0 : 360.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.searchTitle),
      ),
      body: Row(
        children: [
          SizedBox(
            width: sideWidth,
            child: Material(
              color: theme.colorScheme.surface,
              elevation: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: theme.colorScheme.outlineVariant),
                        bottom: BorderSide(color: theme.colorScheme.outlineVariant),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.mosqueListTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        TextButton.icon(
                          onPressed: () => context.go('/search'),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(l10n.openList),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: listPlaceholder(context)),
                ],
              ),
            ),
          ),
          Expanded(child: mapPanel(
            context,
            _mapController,
            _locating,
            _useMyLocation,
            _defaultCenter,
            widget.center,
            widget.radiusKm,
            widget.city,
            widget.q,
          )),
        ],
      ),
    );
  }
}

Widget listPlaceholder(BuildContext context) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.list_alt, size: 64, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              l10n.legacyListTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.legacyListMessage,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.go('/search'),
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.openLegacyListLabel),
            ),
          ],
        ),
      ),
    ),
  );
}

// Terapkan filter berdasarkan query params
List<MasjidModel> _applyFilters(
  List<MasjidModel> input, {
  String? city,
  String? q,
  LatLng? center,
  double? radiusKm,
}) {
  var result = input;

  // Valid hanya yang punya koordinat
  result = result.where((m) => m.latitude != 0.0 && m.longitude != 0.0).toList();

  // Filter kota
  if (city != null && city.trim().isNotEmpty) {
    final cityLower = city.trim().toLowerCase();
    result = result.where((m) => (m.city).toLowerCase() == cityLower).toList();
  }

  // Filter kata kunci
  if (q != null && q.trim().isNotEmpty) {
    final query = q.trim().toLowerCase();
    result = result.where((m) {
      return m.name.toLowerCase().contains(query) ||
          m.city.toLowerCase().contains(query) ||
          m.address.toLowerCase().contains(query);
    }).toList();
  }

  // Filter radius jika center & radius tersedia
  if (center != null && radiusKm != null && radiusKm > 0) {
    final c = center;
    result = result.where((m) {
      final d = calculateDistance(c.latitude, c.longitude, m.latitude, m.longitude);
      return d <= radiusKm;
    }).toList();
  }

  return result;
}

Widget mapPanel(
  BuildContext context,
  MapController mapController,
  bool locating,
  Future<void> Function() onUseMyLocation,
  LatLng defaultCenter,
  LatLng? centerParam,
  double? radiusKm,
  String? city,
  String? q,
) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);
  return Column(
    children: [
      // Toolbar sederhana di atas peta
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
        ),
        child: Row(
          children: [
            FilledButton.icon(
              onPressed: locating ? null : onUseMyLocation,
              icon: locating
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.my_location),
              label: Text(l10n.useMyLocationLabel),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.filtersLabel)),
                );
              },
              icon: const Icon(Icons.tune),
              label: Text(l10n.filtersLabel),
            ),
            const Spacer(),
            IconButton(
              tooltip: l10n.resetToSeoulTooltip,
              onPressed: () => mapController.move(defaultCenter, 11),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      Expanded(
        child: BlocBuilder<MasjidCubit, MasjidState>(
          builder: (context, state) {
            if (state is MasjidLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MasjidFailed) {
              return ErrorStateWidget(
                message: state.error,
                onRetry: () => context.go('/home'),
              );
            }

            final List<MasjidModel> allMasjids;
            if (state is MasjidSuccess) {
              allMasjids = state.masjid;
            } else {
              allMasjids = const [];
            }

            final masjids = _applyFilters(allMasjids, city: city, q: q, center: centerParam, radiusKm: radiusKm);

            // Jika tidak ada hasil setelah filter, tampilkan empty state
            if (masjids.isEmpty) {
              return EmptyStateWidget(
                title: l10n.noMatchingMosquesTitle,
                message: l10n.noMatchingMosquesMessage,
                onAction: () => context.go('/search?view=map'),
                actionLabel: l10n.resetFiltersLabel,
              );
            }

            final markers = masjids
                .map((m) => Marker(
                      width: 44,
                      height: 44,
                      point: LatLng(m.latitude, m.longitude),
                      child: GestureDetector(
                        onTap: () => context.push('/mosques/${m.id}'),
                        child: Icon(
                          Icons.location_on,
                          size: 36,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ))
                .toList();

            // Pusat awal: prioritas center dari URL, lalu rata-rata marker, lalu default
            LatLng center = centerParam ?? defaultCenter;
            if (center == defaultCenter && markers.isNotEmpty) {
              final lat = masjids.map((m) => m.latitude).reduce((a, b) => a + b) / markers.length;
              final lon = masjids.map((m) => m.longitude).reduce((a, b) => a + b) / markers.length;
              center = LatLng(lat, lon);
            }

            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: 11,
                interactionOptions: const InteractionOptions(),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                  subdomains: const ['a', 'b', 'c', 'd'],
                  userAgentPackageName: 'masjid_korea',
                  maxZoom: 20,
                  additionalOptions: const {
                    'attribution': '© OpenStreetMap contributors © CARTO',
                  },
                ),
                MarkerLayer(markers: markers),
              ],
            );
          },
        ),
      ),
    ],
  );
}
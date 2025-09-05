// widgets/filter_chips.dart
// Tujuan: Kumpulan FilterChips (Kota, Radius, Fasilitas, Verified/Terbaru) dengan state eksternal
// Cara pakai: Berikan selectedFilters dan callback onFiltersChanged

import 'package:flutter/material.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<String> selectedFilters;
  final ValueChanged<List<String>> onFiltersChanged;

  const FilterChipsWidget({
    super.key,
    required this.selectedFilters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = <String>[
      l10n.cityFilter,
      l10n.radiusFilter,
      l10n.facilitiesFilter,
      l10n.verifiedFilter,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final selected = selectedFilters.contains(opt);
        return FilterChip(
          label: Text(opt),
          selected: selected,
          onSelected: (value) {
            final updated = [...selectedFilters];
            if (value) {
              updated.add(opt);
            } else {
              updated.remove(opt);
            }
            onFiltersChanged(updated);
          },
          avatar: Icon(
            opt == l10n.cityFilter ? Icons.location_city :
            opt == l10n.radiusFilter ? Icons.social_distance :
            opt == l10n.facilitiesFilter ? Icons.handyman :
            Icons.verified,
            size: 18,
          ),
        );
      }).toList(),
    );
  }
}
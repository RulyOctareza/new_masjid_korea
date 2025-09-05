import 'package:flutter/material.dart';
import 'package:masjid_korea/presentation/extensions/navigator_extensions.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class Searchbox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const Searchbox({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          suffix: IconButton(
            onPressed: () {
              context.goBack();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16.0,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

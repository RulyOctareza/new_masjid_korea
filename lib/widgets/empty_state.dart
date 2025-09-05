// widgets/empty_state.dart
// Tujuan: Menampilkan keadaan kosong (no data) yang ramah dan aksesibel

import 'package:flutter/material.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyStateWidget({
    super.key,
    this.title,
    this.message,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 56, color: theme.hintColor),
            const SizedBox(height: 12),
            Text(title ?? l10n.noData, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              message ?? l10n.noDataMessage,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel ?? l10n.viewOnMap),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// widgets/error_state.dart
// Tujuan: Menampilkan keadaan error dengan aksi retry opsional

import 'package:flutter/material.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
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
            Icon(Icons.error_outline, size: 56, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(
              title ?? l10n.errorTitle,
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: 8),
            Text(
              message ?? l10n.errorMessage,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
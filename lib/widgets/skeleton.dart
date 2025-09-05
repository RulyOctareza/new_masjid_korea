// widgets/skeleton.dart
// Tujuan: Komponen skeleton loading generik

import 'package:flutter/material.dart';

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

class SkeletonGridWidget extends StatelessWidget {
  final int itemCount;
  const SkeletonGridWidget({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => Row(
        children: const [
          Expanded(child: SkeletonBox(width: double.infinity, height: 120)),
        ],
      ),
    );
  }
}
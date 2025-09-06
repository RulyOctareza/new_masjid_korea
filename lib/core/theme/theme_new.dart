// theme/app_theme.dart
import 'package:flutter/material.dart';

class BrandTokens extends ThemeExtension<BrandTokens> {
  final Color accentGold;
  const BrandTokens({required this.accentGold});
  @override
  BrandTokens copyWith({Color? accentGold}) =>
      BrandTokens(accentGold: accentGold ?? this.accentGold);
  @override
  ThemeExtension<BrandTokens> lerp(
    covariant ThemeExtension<BrandTokens>? other,
    double t,
  ) => this;
}

ThemeData buildAppTheme(Brightness brightness) {
  const primary = Color(0xFF1B5E20);
  const surface = Color(0xFFFAFAF9);
  const text = Color(0xFF101828);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      surface: surface,
    ),
    textTheme: Typography.blackMountainView.apply(
      bodyColor: text,
      displayColor: text,
    ),
    extensions: const [BrandTokens(accentGold: Color(0xFFC9A227))],
  );
}

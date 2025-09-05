// theme/app_theme.dart
// Tujuan: Mendefinisikan Material 3 ThemeData dengan token (ThemeExtensions)
// Cara pakai: Import buildAppTheme() dan BrandTokens untuk mengakses warna aksen.
// File ini tidak mengubah perilaku aplikasi saat ini sampai diintegrasikan di main.dart.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Token brand yang dapat diakses via Theme.of(context).extension<BrandTokens>()
class BrandTokens extends ThemeExtension<BrandTokens> {
  final Color accentGold; // Aksen emas tipis
  final Color mutedText; // Warna teks sekunder
  final double radiusMd; // Radius default komponen

  const BrandTokens({
    required this.accentGold,
    required this.mutedText,
    required this.radiusMd,
  });

  @override
  BrandTokens copyWith({Color? accentGold, Color? mutedText, double? radiusMd}) =>
      BrandTokens(
        accentGold: accentGold ?? this.accentGold,
        mutedText: mutedText ?? this.mutedText,
        radiusMd: radiusMd ?? this.radiusMd,
      );

  @override
  ThemeExtension<BrandTokens> lerp(covariant ThemeExtension<BrandTokens>? other, double t) {
    if (other is! BrandTokens) return this;
    return BrandTokens(
      accentGold: Color.lerp(accentGold, other.accentGold, t) ?? accentGold,
      mutedText: Color.lerp(mutedText, other.mutedText, t) ?? mutedText,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t),
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

/// Palet dasar
const _kPrimary = Color(0xFF1B5E20); // emerald/green
const _kPrimary600 = Color(0xFF2E7D32);
const _kAccentGold = Color(0xFFC9A227);
const _kSurface = Color(0xFFFAFAF9);
const _kText = Color(0xFF101828);
const _kMuted = Color(0xFF475467);

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final baseColorScheme = ColorScheme.fromSeed(
    seedColor: _kPrimary,
    brightness: brightness,
    primary: _kPrimary,
    surface: isDark ? const Color(0xFF0F1210) : _kSurface,
  );

  // Tipografi: Inter/Plus Jakarta Sans untuk Latin, Noto Sans KR untuk Korea.
  // Catatan: GoogleFonts akan memilih font sesuai subset karakter secara otomatis.
  final textTheme = GoogleFonts.plusJakartaSansTextTheme(
    (isDark ? Typography.whiteMountainView : Typography.blackMountainView).merge(
      TextTheme(
        titleLarge: GoogleFonts.reemKufi(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    ),
  ).apply(
    bodyColor: isDark ? Colors.white : _kText,
    displayColor: isDark ? Colors.white : _kText,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: baseColorScheme,
    textTheme: textTheme,
    visualDensity: VisualDensity.standard,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    scaffoldBackgroundColor: isDark ? const Color(0xFF0A0D0B) : _kSurface,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: isDark ? Colors.white : _kText,
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? const Color(0xFF151A17) : Colors.white,
      hintStyle: TextStyle(color: _kMuted.withValues(alpha: 0.8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _kMuted.withValues(alpha: 0.25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _kMuted.withValues(alpha: 0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _kPrimary600, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: textTheme.labelLarge?.copyWith(
        color: isDark ? Colors.white : _kText,
      ),
      side: BorderSide(color: _kMuted.withValues(alpha: 0.25)),
      selectedColor: _kPrimary.withValues(alpha: 0.12),
      disabledColor: Colors.grey.withValues(alpha: 0.1),
      backgroundColor: isDark ? const Color(0xFF181C1A) : Colors.white,
      secondarySelectedColor: _kPrimary.withValues(alpha: 0.16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ).merge(
        ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.focused)
                ? _kPrimary.withValues(alpha: 0.24)
                : null,
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: _kMuted.withValues(alpha: 0.18),
      thickness: 1,
    ),
    extensions: const [
      BrandTokens(
        accentGold: _kAccentGold,
        mutedText: _kMuted,
        radiusMd: 12,
      ),
    ],
  );

  return base;
}
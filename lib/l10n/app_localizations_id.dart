// lib/l10n/app_localizations_id.dart
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationsId extends AppLocalizations {
  const AppLocalizationsId(Locale locale) : super(locale);

  @override
  String get appTitle => 'Masjid Korea';
  @override
  String get homeHeadline => 'Temukan Masjid di Korea Selatan';
  @override
  String get homeSubtitle => 'Direktori lengkap masjid.';
  @override
  String get searchHint => 'Cari masjid...';

  @override
  String get noData => 'Tidak ada data';
  @override
  String get noDataMessage => 'Coba ubah kata kunci atau filter pencarian Anda.';

  @override
  String get viewOnMap => 'Lihat dalam Peta';

  @override
  String get errorTitle => 'Terjadi Kesalahan';
  @override
  String get errorMessage => 'Maaf, terjadi masalah saat memuat data.';
  @override
  String get retry => 'Coba lagi';

  @override
  String get nameUnavailable => 'Nama masjid belum tersedia';
  @override
  String get cityUnavailable => 'Kota tidak tersedia';
  @override
  String get verified => 'Terverifikasi';

  // Filters
  @override
  String get cityFilter => 'Kota';
  @override
  String get radiusFilter => 'Radius';
  @override
  String get facilitiesFilter => 'Fasilitas';
  @override
  String get verifiedFilter => 'Terverifikasi';

  // Search/Map page labels
  @override
  String get searchTitle => 'Pencarian Masjid';
  @override
  String get listTabLabel => 'Daftar';
  @override
  String get mapTabLabel => 'Peta';
  @override
  String get mosqueListTitle => 'Daftar Masjid';
  @override
  String get openList => 'Buka Daftar';
  @override
  String get searchResultsTitle => 'Hasil Pencarian';
  @override
  String get mosqueListKoreaTitle => 'Daftar Masjid di Korea Selatan';

  // Mosque detail page
  @override
  String get mosqueDetailTitle => 'Detail Masjid';
  @override
  String get addressLabel => 'Alamat';
  @override
  String get addressUnavailable => 'Alamat belum tersedia';
  @override
  String get openInMaps => 'Buka di Maps';
  @override
  String failedOpenMap(String error) => 'Gagal membuka peta: $error';
  @override
  String photoSemantics(int index, int total) => 'Foto masjid ${index + 1} dari $total';
  // Duplicate openList removed

  // Search page header (marketing)
  @override
  String get searchWelcomeTitle => 'Selamat Datang di Masjid Korea';
  @override
  String get searchWelcomeSubtitle => 'Temukan masjid terdekat di Korea Selatan dengan mudah dan cepat.';
  @override
  String get searchStartCta => 'Mulai Cari';

  // Location messages
  @override
  String get locationCenteredMsg => 'Lokasi ditemukan. Peta dipusatkan.';
  @override
  String get locationPermissionError => 'Tidak dapat mengakses lokasi. Periksa izin.';
  @override
  String locationFailedMessage(String error) => 'Gagal mendapatkan lokasi: $error';

  // Map toolbar labels
  @override
  String get useMyLocationLabel => 'Gunakan Lokasi Saya';
  @override
  String get filtersLabel => 'Filter';
  @override
  String get resetToSeoulTooltip => 'Reset ke Seoul';

  // Empty state messages for search results
  @override
  String get noMatchingMosquesTitle => 'Tidak ada masjid yang cocok';
  @override
  String get noMatchingMosquesMessage => 'Coba ubah kata kunci atau filter pencarian Anda.';
  @override
  String get resetFiltersLabel => 'Reset filter';

  // Legacy list placeholder
  @override
  String get legacyListTitle => 'Daftar Masjid (legacy)';
  @override
  String get legacyListMessage => 'Daftar masjid versi lama akan tetap tersedia. Klik tombol di bawah untuk membuka tampilan daftar klasik.';
  @override
  String get openLegacyListLabel => 'Buka Daftar (Legacy)';

  @override
  String mosqueCardLabel(String name) => 'Kartu masjid $name';
  // Routing and generic messages
  @override
  String get invalidMosqueId => 'ID masjid tidak valid';
  @override
  String get mosqueNotFound => 'Masjid tidak ditemukan';
  @override
  String pageNotFound(String error) => 'Halaman tidak ditemukan: $error';

  @override
  String get prayerTimesTitle => 'Jadwal Sholat';
  @override
  String get prayerTimesMessage => 'Dihitung menggunakan metode Muslim World League (MWL).';
  @override
  String get fajrLabel => 'Subuh';
  @override
  String get sunriseLabel => 'Matahari Terbit';
  @override
  String get dhuhrLabel => 'Zuhur';
  @override
  String get asrLabel => 'Asar';
  @override
  String get maghribLabel => 'Maghrib';
  @override
  String get ishaLabel => 'Isya';

  // Time zone badge label for Prayer Times
  @override
  String get timeZoneKstGmt9 => 'KST (GMT+9)';

  // Additional UI strings
  @override
  String get photosTitle => 'Foto';
  @override
  String get goToMasjidLabel => 'Pergi ke Masjid';
  @override
  String get locationLabel => 'Lokasi';
  @override
  String get locationCopiedMessage => 'Lokasi disalin ke papan klip!';
  @override
  String get exploreNowLabel => 'Jelajahi Sekarang';
  @override
  String get letsGoToMosqueLabel => 'Ayo ke Masjid!';
  @override
  String get noMosqueInCommunityMessage => 'Tidak ada masjid di komunitas ini';
  @override
  String get noMosqueMessage => 'Tidak ada masjid';
  @override
  String get pleaseAllowLocationMessage => 'Mohon izinkan layanan lokasi!';
  @override
  String get tryAgainLabel => 'Coba Lagi!';
  @override
  String get mosquesClosestToYouLabel => 'Masjid terdekat denganmu';
  @override
  String mosqueInAreaTitle(String community) => 'Masjid di Area $community';
  @override
  String failedToLoadMosqueMessage(String error) => 'Gagal memuat masjid: $error';

  // Tooltips & semantics for detail actions
  @override
  String get copyLocationTooltip => 'Salin lokasi';
  @override
  String get openMapTooltip => 'Buka di Kakao Map';

  // Language switcher strings
  @override
  String get changeLanguageLabel => 'Ganti bahasa';
  @override
  String get chooseLanguageHint => 'Pilih bahasa aplikasi';
  @override
  String get languageSwitcherTooltip => 'Ganti bahasa';
  @override
  String get languageIndonesian => 'Indonesia';
  @override
  String get languageEnglish => 'Inggris';
  @override
  String get languageKorean => 'Korea';

  // Tema toggle strings
  @override
  String get themeToggleLabel => 'Ganti tema';
  @override
  String get themeToggleHintDark => 'Saat ini gelap, tekan untuk terang';
  @override
  String get themeToggleHintLight => 'Saat ini terang, tekan untuk gelap';
  @override
  String get themeToggleTooltip => 'Ganti tema';

  // Semantik aset aplikasi
  @override
  String get appLogoSemanticLabel => 'Logo KMI';

  // Misc placeholders
  @override
  String get galleryTodoPlaceholder => 'TODO: Integrasi Gallery via go_router';
}
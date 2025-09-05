// lib/l10n/app_localizations.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ko.dart';

abstract class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(l10n != null, 'AppLocalizations not found in context');
    return l10n!;
  }

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ko'),
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  String get appTitle;
  String get homeHeadline;
  String get homeSubtitle;
  String get searchHint;

  String get noData;
  String get noDataMessage;

  String get viewOnMap;

  String get errorTitle;
  String get errorMessage;
  String get retry;

  String get nameUnavailable;
  String get cityUnavailable;
  String get verified;

  // Filter labels
  String get cityFilter;
  String get radiusFilter;
  String get facilitiesFilter;
  String get verifiedFilter;

  // Search/Map page labels
  String get searchTitle; // AppBar title
  String get listTabLabel; // Bottom nav/tab label for list
  String get mapTabLabel; // Bottom nav/tab label for map
  String get mosqueListTitle; // Section title on desktop/tablet
  String get openList; // Button label to open list page

  // Search page header (marketing)
  String get searchWelcomeTitle;
  String get searchWelcomeSubtitle;
  String get searchStartCta;

  // Location messages
  String get locationCenteredMsg;
  String get locationPermissionError;
  String locationFailedMessage(String error);

  // Map toolbar labels
  String get useMyLocationLabel;
  String get filtersLabel;
  String get resetToSeoulTooltip;

  // Empty state messages for search results
  String get noMatchingMosquesTitle;
  String get noMatchingMosquesMessage;
  String get resetFiltersLabel;

  // Legacy list placeholder
  String get legacyListTitle;
  String get legacyListMessage;
  String get openLegacyListLabel;

  // Search list titles
  String get searchResultsTitle;
  String get mosqueListKoreaTitle;

  // Mosque detail page
  String get mosqueDetailTitle;
  String get addressLabel;
  String get addressUnavailable;
  String get openInMaps;
  String failedOpenMap(String error);
  String photoSemantics(int index, int total);

  // Routing and generic messages
  String get invalidMosqueId;
  String get mosqueNotFound;
  String pageNotFound(String error);

  // Prayer times stub
  String get prayerTimesTitle;
  String get prayerTimesMessage;

  // Additional UI strings
  String get photosTitle;
  String get goToMasjidLabel;
  String get locationLabel;
  String get locationCopiedMessage;
  String get exploreNowLabel;
  String get letsGoToMosqueLabel;
  String get noMosqueInCommunityMessage;
  String get noMosqueMessage;
  String get pleaseAllowLocationMessage;
  String get tryAgainLabel;
  String get mosquesClosestToYouLabel;
  String mosqueInAreaTitle(String community);
  String failedToLoadMosqueMessage(String error);

  // Tooltips & semantics for detail actions
  String get copyLocationTooltip;
  String get openMapTooltip;

  String mosqueCardLabel(String name);

  // Language switcher & language names
  String get changeLanguageLabel; // Semantics label
  String get chooseLanguageHint; // Semantics hint
  String get languageSwitcherTooltip; // Tooltip
  String get languageIndonesian;
  String get languageEnglish;
  String get languageKorean;

  // Theme toggle
  String get themeToggleLabel;
  String get themeToggleHintDark;
  String get themeToggleHintLight;
  String get themeToggleTooltip;

  // App assets semantics
  String get appLogoSemanticLabel;

  // Misc placeholders
  String get galleryTodoPlaceholder;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'id', 'ko'].contains(locale.languageCode.toLowerCase());

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode.toLowerCase()) {
      case 'id':
        return AppLocalizationsId(locale);
      case 'ko':
        return AppLocalizationsKo(locale);
      case 'en':
      default:
        return AppLocalizationsEn(locale);
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
// lib/l10n/app_localizations_en.dart
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  const AppLocalizationsEn(Locale locale) : super(locale);

  @override
  String get appTitle => 'Korea Mosque';
  @override
  String get homeHeadline => 'Find Mosques in South Korea';
  @override
  String get homeSubtitle => 'A complete directory of mosques.';
  @override
  String get searchHint => 'Search mosques...';

  @override
  String get noData => 'No data';
  @override
  String get noDataMessage => 'Try changing your keywords or filters.';

  @override
  String get viewOnMap => 'View on Map';

  @override
  String get errorTitle => 'An Error Occurred';
  @override
  String get errorMessage => 'Sorry, there was a problem while loading data.';
  @override
  String get retry => 'Retry';

  @override
  String get nameUnavailable => 'Mosque name is unavailable';
  @override
  String get cityUnavailable => 'City is unavailable';
  @override
  String get verified => 'Verified';

  // Filters
  @override
  String get cityFilter => 'City';
  @override
  String get radiusFilter => 'Radius';
  @override
  String get facilitiesFilter => 'Facilities';
  @override
  String get verifiedFilter => 'Verified';

  // Search/Map page labels
  @override
  String get searchTitle => 'Mosque Search';
  @override
  String get listTabLabel => 'List';
  @override
  String get mapTabLabel => 'Map';
  @override
  String get mosqueListTitle => 'Mosque List';
  @override
  String get openList => 'Open List';

  // Search page header (marketing)
  @override
  String get searchWelcomeTitle => 'Welcome to Korea Mosque';
  @override
  String get searchWelcomeSubtitle => 'Find nearby mosques in South Korea easily and quickly.';
  @override
  String get searchStartCta => 'Start Searching';

  // Location messages
  @override
  String get locationCenteredMsg => 'Location found. Map centered.';
  @override
  String get locationPermissionError => 'Unable to access location. Check permissions.';
  @override
  String locationFailedMessage(String error) => 'Failed to get location: $error';

  // Map toolbar labels
  @override
  String get useMyLocationLabel => 'Use My Location';
  @override
  String get filtersLabel => 'Filters';
  @override
  String get resetToSeoulTooltip => 'Reset to Seoul';

  // Empty state messages for search results
  @override
  String get noMatchingMosquesTitle => 'No matching mosques';
  @override
  String get noMatchingMosquesMessage => 'Try changing your keywords or filters.';
  @override
  String get resetFiltersLabel => 'Reset filters';

  // Legacy list placeholder
  @override
  String get legacyListTitle => 'Mosque List (legacy)';
  @override
  String get legacyListMessage => 'The legacy mosque list will remain available. Click the button below to open the classic list view.';
  @override
  String get openLegacyListLabel => 'Open Legacy List';

  @override
  String mosqueCardLabel(String name) => 'Mosque card $name';

  // Search list titles
  @override
  String get searchResultsTitle => 'Search Results';
  @override
  String get mosqueListKoreaTitle => 'Mosques in South Korea';

  // Mosque detail page
  @override
  String get mosqueDetailTitle => 'Mosque Detail';
  @override
  String get addressLabel => 'Address';
  @override
  String get addressUnavailable => 'Address is unavailable';
  @override
  String get openInMaps => 'Open in Maps';
  @override
  String failedOpenMap(String error) => 'Failed to open map: $error';
  @override
  String photoSemantics(int index, int total) => 'Mosque photo ${index + 1} of $total';
  // Routing and generic messages
  @override
  String get invalidMosqueId => 'Invalid mosque ID';
  @override
  String get mosqueNotFound => 'Mosque not found';
  @override
  String pageNotFound(String error) => 'Page not found: $error';

  @override
  String get prayerTimesTitle => 'Prayer Times';
  @override
  String get prayerTimesMessage => 'Calculated using Muslim World League (MWL) method.';
  @override
  String get fajrLabel => 'Fajr';
  @override
  String get sunriseLabel => 'Sunrise';
  @override
  String get dhuhrLabel => 'Dhuhr';
  @override
  String get asrLabel => 'Asr';
  @override
  String get maghribLabel => 'Maghrib';
  @override
  String get ishaLabel => 'Isha';

  // Time zone badge label for Prayer Times
  @override
  String get timeZoneKstGmt9 => 'KST (GMT+9)';

  // Additional UI strings
  @override
  String get photosTitle => 'Photos';
  @override
  String get goToMasjidLabel => 'Go to Mosque';
  @override
  String get locationLabel => 'Location';
  @override
  String get locationCopiedMessage => 'Location copied to clipboard!';
  @override
  String get exploreNowLabel => 'Explore Now';
  @override
  String get letsGoToMosqueLabel => "Let's go to Mosque!";
  @override
  String get noMosqueInCommunityMessage => 'No mosques in the community';
  @override
  String get noMosqueMessage => 'No mosques';
  @override
  String get pleaseAllowLocationMessage => 'Please allow location services!';
  @override
  String get tryAgainLabel => 'Try Again!';
  @override
  String get mosquesClosestToYouLabel => 'Mosques closest to you';
  @override
  String mosqueInAreaTitle(String community) => 'Mosque in Area $community';
  @override
  String failedToLoadMosqueMessage(String error) => 'Failed to load mosque: $error';

  // Tooltips & semantics for detail actions
  @override
  String get copyLocationTooltip => 'Copy location';
  @override
  String get openMapTooltip => 'Open in Kakao Map';

  // Language switcher strings
  @override
  String get changeLanguageLabel => 'Change language';
  @override
  String get chooseLanguageHint => 'Choose app language';
  @override
  String get languageSwitcherTooltip => 'Change language';
  @override
  String get languageIndonesian => 'Indonesian';
  @override
  String get languageEnglish => 'English';
  @override
  String get languageKorean => 'Korean';

  // Theme toggle strings
  @override
  String get themeToggleLabel => 'Change theme';
  @override
  String get themeToggleHintDark => 'Currently dark, tap to switch to light';
  @override
  String get themeToggleHintLight => 'Currently light, tap to switch to dark';
  @override
  String get themeToggleTooltip => 'Change theme';

  // App assets semantics
  @override
  String get appLogoSemanticLabel => 'KMI Logo';

  // Misc placeholders
  @override
  String get galleryTodoPlaceholder => 'TODO: Integrate Gallery via go_router';
}
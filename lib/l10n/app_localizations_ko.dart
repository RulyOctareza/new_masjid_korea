// lib/l10n/app_localizations_ko.dart
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationsKo extends AppLocalizations {
  const AppLocalizationsKo(Locale locale) : super(locale);

  @override
  String get appTitle => '코리아 모스크';
  @override
  String get homeHeadline => '한국의 모스크를 찾아보세요';
  @override
  String get homeSubtitle => '모스크의 종합 디렉터리.';
  @override
  String get searchHint => '모스크 검색...';

  @override
  String get noData => '데이터가 없습니다';
  @override
  String get noDataMessage => '키워드나 필터를 변경해 보세요.';

  @override
  String get viewOnMap => '지도에서 보기';

  @override
  String get errorTitle => '오류가 발생했습니다';
  @override
  String get errorMessage => '데이터를 불러오는 중 문제가 발생했습니다.';
  @override
  String get retry => '다시 시도';

  @override
  String get nameUnavailable => '모스크 이름을 확인할 수 없습니다';
  @override
  String get cityUnavailable => '도시 정보를 확인할 수 없습니다';
  @override
  String get verified => '인증됨';

  // Filters
  @override
  String get cityFilter => '도시';
  @override
  String get radiusFilter => '반경';
  @override
  String get facilitiesFilter => '시설';
  @override
  String get verifiedFilter => '인증됨';

  // Search/Map page labels
  @override
  String get searchTitle => '모스크 검색';
  @override
  String get listTabLabel => '목록';
  @override
  String get mapTabLabel => '지도';
  @override
  String get mosqueListTitle => '모스크 목록';
  @override
  String get openList => '목록 열기';

  // Search list titles
  @override
  String get searchResultsTitle => '검색 결과';
  @override
  String get mosqueListKoreaTitle => '한국의 모스크 목록';

  // Mosque detail page
  @override
  String get mosqueDetailTitle => '모스크 상세';
  @override
  String get addressLabel => '주소';
  @override
  String get addressUnavailable => '주소를 확인할 수 없습니다';
  @override
  String get openInMaps => '지도에서 열기';
  @override
  String failedOpenMap(String error) => '지도를 열지 못했습니다: $error';
  @override
  String photoSemantics(int index, int total) => '모스크 사진 ${index + 1} / $total';

  // Search page header (marketing)
  @override
  String get searchWelcomeTitle => '코리아 모스크에 오신 것을 환영합니다';
  @override
  String get searchWelcomeSubtitle => '한국에서 가까운 모스크를 쉽고 빠르게 찾아보세요.';
  @override
  String get searchStartCta => '검색 시작';

  // Location messages
  @override
  String get locationCenteredMsg => '위치를 찾았습니다. 지도를 중앙으로 이동했습니다.';
  @override
  String get locationPermissionError => '위치에 접근할 수 없습니다. 권한을 확인하세요.';
  @override
  String locationFailedMessage(String error) => '위치를 가져오지 못했습니다: $error';

  // Map toolbar labels
  @override
  String get useMyLocationLabel => '내 위치 사용';
  @override
  String get filtersLabel => '필터';
  @override
  String get resetToSeoulTooltip => '서울로 재설정';

  // Empty state messages for search results
  @override
  String get noMatchingMosquesTitle => '일치하는 모스크가 없습니다';
  @override
  String get noMatchingMosquesMessage => '키워드나 필터를 변경해 보세요.';
  @override
  String get resetFiltersLabel => '필터 초기화';

  // Legacy list placeholder
  @override
  String get legacyListTitle => '모스크 목록 (레거시)';
  @override
  String get legacyListMessage => '레거시 모스크 목록은 계속 이용할 수 있습니다. 아래 버튼을 눌러 클래식 목록을 여세요.';
  @override
  String get openLegacyListLabel => '레거시 목록 열기';

  @override
  String mosqueCardLabel(String name) => '모스크 카드 $name';
  // Routing and generic messages
  @override
  String get invalidMosqueId => '잘못된 모스크 ID';
  @override
  String get mosqueNotFound => '모스크를 찾을 수 없습니다';
  @override
  String pageNotFound(String error) => '페이지를 찾을 수 없습니다: $error';

  @override
  String get prayerTimesTitle => '기도 시간';
  @override
  String get prayerTimesMessage => 'Muslim World League (MWL) 방식으로 계산되었습니다.';
  @override
  String get fajrLabel => '파즈르';
  @override
  String get sunriseLabel => '일출';
  @override
  String get dhuhrLabel => '주후(두후르)';
  @override
  String get asrLabel => '아스르';
  @override
  String get maghribLabel => '마그립';
  @override
  String get ishaLabel => '이샤';
  
  // Time zone badge label for Prayer Times
  @override
  String get timeZoneKstGmt9 => 'KST (GMT+9)';
  
  // Additional UI strings
  @override
  String get photosTitle => '사진';
  @override
  String get goToMasjidLabel => '모스크로 가기';
  @override
  String get locationLabel => '위치';
  @override
  String get locationCopiedMessage => '위치가 클립보드에 복사되었습니다!';
  @override
  String get exploreNowLabel => '지금 탐색하기';
  @override
  String get letsGoToMosqueLabel => '모스크로 가자!';
  @override
  String get noMosqueInCommunityMessage => '커뮤니티에 모스크가 없습니다';
  @override
  String get noMosqueMessage => '모스크 없음';
  @override
  String get pleaseAllowLocationMessage => '위치 서비스를 허용해 주세요!';
  @override
  String get tryAgainLabel => '다시 시도!';
  @override
  String get mosquesClosestToYouLabel => '가장 가까운 모스크';
  @override
  String mosqueInAreaTitle(String community) => '해당 지역의 모스크 $community';
  @override
  String failedToLoadMosqueMessage(String error) => '모스크 불러오기 실패: $error';

  // Tooltips & semantics for detail actions
  @override
  String get copyLocationTooltip => '위치 복사';
  @override
  String get openMapTooltip => '카카오맵에서 열기';

  // Language switcher strings
  @override
  String get changeLanguageLabel => '언어 변경';
  @override
  String get chooseLanguageHint => '앱 언어를 선택하세요';
  @override
  String get languageSwitcherTooltip => '언어 변경';
  @override
  String get languageIndonesian => '인도네시아어';
  @override
  String get languageEnglish => '영어';
  @override
  String get languageKorean => '한국어';

  // 테마 토글 문자열
  @override
  String get themeToggleLabel => '테마 변경';
  @override
  String get themeToggleHintDark => '현재 다크 모드입니다. 탭하여 라이트로 전환';
  @override
  String get themeToggleHintLight => '현재 라이트 모드입니다. 탭하여 다크로 전환';
  @override
  String get themeToggleTooltip => '테마 변경';

  // 앱 자산 접근성 레이블
  @override
  String get appLogoSemanticLabel => 'KMI 로고';

  // Misc placeholders
  @override
  String get galleryTodoPlaceholder => 'TODO: go_router로 갤러리 연동';
}
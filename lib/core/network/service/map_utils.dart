import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  Future<void> openKakaoMap(String address) async {
    final Uri url = Uri.parse(address);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openUrlInBrowser(String link) async {
    final Uri fblink = Uri.parse(link);
    if (await canLaunchUrl(fblink)) {
      await launchUrl(fblink, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $fblink';
    }
  }
}

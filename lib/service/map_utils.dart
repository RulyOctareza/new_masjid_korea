import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  Future<void> openKakaoMap(String address) async {
    final Uri url = Uri.parse(address);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

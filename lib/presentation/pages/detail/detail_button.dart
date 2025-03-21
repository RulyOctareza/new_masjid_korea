import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/network/service/map_utils.dart';
import 'package:masjid_korea/core/theme/theme.dart';

class DetailButton extends StatelessWidget {
  final MasjidModel masjid;

  const DetailButton({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: edge),
      height: 50,
      width: MediaQuery.of(context).size.width - (2 * edge),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: () async {
          await MapUtils().openKakaoMap(masjid.address);
        },
        style: ElevatedButton.styleFrom(backgroundColor: purpleColor),
        child: Text('Go to Masjid', style: whiteTextStyle),
      ),
    );
  }
}

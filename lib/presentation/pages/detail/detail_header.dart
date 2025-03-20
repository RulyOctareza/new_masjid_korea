import 'package:flutter/material.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';

class DetailHeader extends StatelessWidget {
  final MasjidModel masjid;

  const DetailHeader({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        masjid.imageUrl,
        width: 300,
        height: 300,
        fit: BoxFit.fitHeight,
        semanticLabel: masjid.name,
      ),
    );
  }
}

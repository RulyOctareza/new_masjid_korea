import 'package:flutter/material.dart';
import 'package:masjid_korea/presentation/extensions/navigator_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class GalleryPage extends StatelessWidget {
  final MasjidModel masjid;
  const GalleryPage(this.masjid, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.photosTitle)),
      body: Column(
        children: [
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 150, // Ukuran maksimum setiap elemen di grid
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              children: masjid.photos.map((photo) => _buildImageAsset(photo, context)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageAsset(String assetName, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          _showImageDialog(assetName, context);
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(assetName),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _showImageDialog(String assetName, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              context.goBack();
            },
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(assetName),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

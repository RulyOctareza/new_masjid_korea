import 'package:flutter/material.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';

class GalleryPage extends StatelessWidget {
  final MasjidModel masjid;
  const GalleryPage(this.masjid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: Column(
        children: [
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 150, // Ukuran maksimum setiap elemen di grid
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              children: [
                _buildImageAsset(masjid.photos1, context),
                _buildImageAsset(masjid.photos2, context),
                _buildImageAsset(masjid.photos3, context),
                _buildImageAsset(masjid.photos4, context),
                _buildImageAsset(masjid.photos5, context),
                _buildImageAsset(masjid.photos6, context),
                _buildImageAsset(masjid.photos1, context),
                _buildImageAsset(masjid.photos2, context),
                _buildImageAsset(masjid.photos3, context),
                _buildImageAsset(masjid.photos4, context),
                _buildImageAsset(masjid.photos5, context),
                _buildImageAsset(masjid.photos6, context),
              ],
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
              Navigator.of(context).pop();
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

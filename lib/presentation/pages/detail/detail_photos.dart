import 'package:flutter/material.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/gallery/gallery_page.dart';

class DetailPhotos extends StatelessWidget {
  final MasjidModel masjid;

  DetailPhotos({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            'Photos',
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16.toDouble(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GalleryPage(masjid)),
              );
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 24),
                ...List.generate(6, (index) {
                  final photo = _getPhotoByIndex(index);
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        photo,
                        width: 110,
                        height: 88,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getPhotoByIndex(int index) {
    switch (index) {
      case 0:
        return masjid.photos1;
      case 1:
        return masjid.photos2;
      case 2:
        return masjid.photos3;
      case 3:
        return masjid.photos4;
      case 4:
        return masjid.photos5;
      case 5:
        return masjid.photos6;
      default:
        return '';
    }
  }
}

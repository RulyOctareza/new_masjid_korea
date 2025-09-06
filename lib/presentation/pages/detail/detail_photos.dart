import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:go_router/go_router.dart';

class DetailPhotos extends StatelessWidget {
  final MasjidModel masjid;

  DetailPhotos({super.key, required this.masjid});

  @override
  Widget build(BuildContext context) {
    final List<String> photos = masjid.photos;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Photos',
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: InkWell(
            onTap: () {
              context.push('/gallery');
            },
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 24 : 0,
                      right: 18,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        photos[index],
                        width: 110,
                        height: 88,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

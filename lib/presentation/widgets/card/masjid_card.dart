import 'package:flutter/material.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/presentation/extensions/theme_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

class MasjidCard extends StatelessWidget {
  final MasjidModel masjid;
  final double? distance;

  const MasjidCard(this.masjid, {this.distance, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        context.push('/mosques/${masjid.id}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: edge),
        padding: EdgeInsets.symmetric(horizontal: edge, vertical: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(masjid.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    masjid.name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    masjid.city,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    masjid.location,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  if (distance != null)
                    Text(
                      '${distance!.toStringAsFixed(2)} km',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

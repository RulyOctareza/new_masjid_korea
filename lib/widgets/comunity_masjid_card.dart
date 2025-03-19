import 'package:flutter/material.dart';
import 'package:masjid_korea/extensions/navigator_extensions.dart';
import 'package:masjid_korea/extensions/text_extensions.dart';


class KomunitasMasjid extends StatelessWidget {
  final String communityName;
  final String imageUrl;

  const KomunitasMasjid({
    super.key,
    required this.communityName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateTo('/comunity');
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green[300],
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Text(
              communityName,
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 12.toDouble(),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

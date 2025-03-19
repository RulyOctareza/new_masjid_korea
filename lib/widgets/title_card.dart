import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/cubit/theme_masjid.dart';
import 'package:masjid_korea/extensions/navigator_extensions.dart';
import 'package:masjid_korea/extensions/text_extensions.dart';
import 'package:masjid_korea/styles/theme.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: edge, right: edge),
                child: Text('Explore Now', style: context.textTheme.titleLarge),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: const Icon(Icons.brightness_6),
              ),
              IconButton(
                onPressed: () {
                  context.navigateTo('/search');
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: EdgeInsets.only(left: edge),
          child: Text(
            'Let\'s go to Mosque !',
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/presentation/cubit/theme_masjid.dart';
import 'package:masjid_korea/presentation/extensions/navigator_extensions.dart';
import 'package:masjid_korea/presentation/extensions/text_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_button.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_header.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_location.dart';
import 'package:masjid_korea/presentation/pages/detail/detail_photos.dart';
import 'package:masjid_korea/core/theme/theme.dart';

class DetailPage extends StatefulWidget {
  final MasjidModel masjid;

  const DetailPage({super.key, required this.masjid});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Scaffold(
          backgroundColor:
              themeMode == ThemeMode.dark ? blackColor : whiteColor,
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Container(
                        width: double.infinity,
                        color: Color.fromRGBO(242, 242, 242, 1),
                        child: DetailHeader(masjid: widget.masjid),
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                    ),
                    ListView(
                        children: [
                          const SizedBox(height: 280),
                          BlocBuilder<ThemeCubit, ThemeMode>(
                            builder: (context, themeMode) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                      themeMode == ThemeMode.dark
                                          ? blackColor
                                          : whiteColor,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.masjid.name,
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(fontSize: 32.toDouble()),
                                      ),
                                    ),
                                    DetailPhotos(masjid: widget.masjid),
                                    const SizedBox(height: 30),
                                    DetailLocation(masjid: widget.masjid),
                                    const SizedBox(height: 25),
                                    DetailButton(masjid: widget.masjid),
                                    const SizedBox(height: 50),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                    Positioned(
                      top: 16,
                      left: 5,
                      child: IconButton(
                        onPressed: () {
                          context.goBack();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color:
                              themeMode == ThemeMode.dark
                                  ? whiteColor
                                  : blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

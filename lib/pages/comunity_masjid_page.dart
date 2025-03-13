import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/cubit/masjid_cubit.dart';
import 'package:masjid_korea/cubit/theme_masjid.dart';
import 'package:masjid_korea/styles/theme.dart';
import 'package:masjid_korea/widgets/card/masjid_card.dart';

class CommunityMasjidPage extends StatelessWidget {
  final String community;

  const CommunityMasjidPage(this.community, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Scaffold(
                  backgroundColor:
                      themeMode == ThemeMode.dark
                          ? kDefaultIconDarkColor
                          : whiteColor,
                  appBar: AppBar(
                    title: Text(
                      'Mosque in Area $community',
                      style:
                          themeMode == ThemeMode.dark
                              ? whiteTextStyle
                              : blackTextStyle,
                    ),
                    backgroundColor:
                        themeMode == ThemeMode.dark
                            ? kDefaultIconDarkColor
                            : whiteColor,
                  ),
                  body: SafeArea(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: BlocBuilder<MasjidCubit, MasjidState>(
                          builder: (context, state) {
                            if (state is MasjidSuccess) {
                              final masjids =
                                  state.masjid
                                      .where(
                                        (masjid) =>
                                            masjid.comunity == community,
                                      )
                                      .toList();

                              if (masjids.isEmpty) {
                                return const Center(
                                  child: Text('No Mosque in the Community'),
                                );
                              }

                              return ListView.builder(
                                itemCount: masjids.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      MasjidCard(masjids[index]),
                                    ],
                                  );
                                },
                              );
                            } else if (state is MasjidLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is MasjidFailed) {
                              return Center(
                                child: Text(
                                  'Failed to load Mosque: ${state.error}',
                                ),
                              );
                            } else {
                              return const Center(child: Text('No Mosque'));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

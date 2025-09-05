import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/presentation/cubit/theme_masjid.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:masjid_korea/presentation/widgets/card/masjid_card.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';

class CommunityMasjidPage extends StatelessWidget {
  final String community;

  const CommunityMasjidPage(this.community, {super.key,});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                      l10n.mosqueInAreaTitle(community),
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
                                return Center(
                                  child: Text(l10n.noMosqueInCommunityMessage),
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
                              return  Center(
                                child: Lottie.asset(
                                  'assets/loading.json',
                                  width: 150,
                                  height: 150,
                                ),
                              );
                            } else if (state is MasjidFailed) {
                              return Center(
                                child: Text(
                                  l10n.failedToLoadMosqueMessage(state.error),
                                ),
                              );
                            } else {
                              return Center(child: Text(l10n.noMosqueMessage));
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

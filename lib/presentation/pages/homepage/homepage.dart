import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/presentation/extensions/theme_extensions.dart';
import 'package:masjid_korea/presentation/extensions/navigator_extensions.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/masjid_terdekat/masjid_terdekat.dart';
import 'package:masjid_korea/core/theme/theme.dart';
import 'package:masjid_korea/presentation/widgets/card/comunity_masjid.dart';
import 'package:masjid_korea/presentation/widgets/rekomendasi_masjid.dart';
import 'package:masjid_korea/presentation/widgets/title_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.rekomendasiMasjid,
    required this.comunityMasjid,
  });

  @override
  State<Homepage> createState() => _HomepageState();

  final List<MasjidModel> rekomendasiMasjid;
  final List<MasjidModel> comunityMasjid;
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<MasjidCubit>().fetchMasjid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: BlocConsumer<MasjidCubit, MasjidState>(
              listener: (context, state) {
                if (state is MasjidFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: purpleColor,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MasjidSuccess) {
                  return ListView(
                    children: [
                      TitleCard(),
                      ComunityMasjid(masjid: state.masjid),
                      RekomendasiMasjid(masjid: state.masjid),
                      MasjidTerdekat(masjids: state.masjid),
                    ],
                  );
                }
                return Center(
                  child: Lottie.asset(
                    'assets/loading.json',
                    width: 150,
                    height: 150,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.navigateTo('/admin_login');
        },
        label: const Text('Admin Login'),
        icon: const Icon(Icons.admin_panel_settings),
      ),
    );
  }
}

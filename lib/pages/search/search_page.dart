import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid_korea/cubit/masjid_cubit.dart';
import 'package:masjid_korea/extensions/text_extensions.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/styles/theme.dart';
import 'package:masjid_korea/widgets/card/masjid_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MasjidModel> _filteredMasjids = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final masjids =
        context.read<MasjidCubit>().state is MasjidSuccess
            ? (context.read<MasjidCubit>().state as MasjidSuccess).masjid
            : <MasjidModel>[];
    setState(() {
      _filteredMasjids =
          masjids
              .where(
                (masjid) => masjid.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari Masjid...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }

  Widget daftarMasjid(List<MasjidModel> masjids) {
    List<MasjidModel> displayMasjids =
        _searchController.text.isEmpty ? masjids : _filteredMasjids;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: edge, top: edge),
          child: Text(
            'Daftar Masjid di Korea Selatan',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
        ),
        const SizedBox(height: 5),
        searchBox(),
        const SizedBox(height: 16),
        Column(
          children:
              displayMasjids.map((MasjidModel masjid) {
                return Column(
                  children: [MasjidCard(masjid), const SizedBox(height: 10)],
                );
              }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<MasjidCubit, MasjidState>(
          builder: (context, state) {
            if (state is MasjidSuccess) {
              if (_filteredMasjids.isEmpty) {
                _filteredMasjids = state.masjid;
              }
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        return ListView(children: [daftarMasjid(state.masjid)]);
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    elevation: 4,
                                    child: SizedBox(
                                      height: 300,

                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          16.0,
                                        ),
                                        child: Image.asset(
                                          'assets/images/masjid.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 32),

                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Selamat Datang di Korea Masjid',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Temukan masjid terdekat di Korea Selatan dengan mudah dan cepat.',
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(fontSize: 16.toDouble()),
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Mulai Cari'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

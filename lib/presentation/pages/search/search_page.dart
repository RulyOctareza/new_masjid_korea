import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_korea/presentation/cubit/masjid_cubit.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/presentation/pages/search/daftar_masjid.dart';
import 'package:masjid_korea/presentation/pages/search/searchbox.dart';
import 'package:masjid_korea/presentation/pages/search/searchpage_header.dart';

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
                        return ListView(
                          children: [
                            Searchbox(
                              controller: _searchController,
                              onChanged: (value) => _onSearchChanged(),
                            ),
                            DaftarMasjid(
                              masjids: _filteredMasjids,
                              isSearching: _searchController.text.isNotEmpty,
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const SearchpageHeader(),
                              const SizedBox(height: 32),
                              Searchbox(
                                controller: _searchController,
                                onChanged: (value) => _onSearchChanged(),
                              ),
                              DaftarMasjid(
                                masjids: _filteredMasjids,
                                isSearching: _searchController.text.isNotEmpty,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
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
    );
  }
}

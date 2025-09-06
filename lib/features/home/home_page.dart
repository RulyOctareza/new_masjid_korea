// features/home/home_page.dart
// Tujuan: Halaman beranda dengan hero section, pencarian, filter chips, dan grid masjid.
// Cara pakai: Gunakan sebagai pengganti homepage lama jika ingin UI baru (saat ini belum diintegrasikan).
// Desain: Material 3 + Brand tokens, responsif (<600, 600-1024, >1024), aksesibilitas WCAG AA.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import '../../theme/app_theme.dart';
import '../../presentation/cubit/masjid_cubit.dart';
import '../mosque/widgets/mosque_card.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/skeleton.dart';
import '../../widgets/error_state.dart';
import '../../widgets/language_switcher.dart';
import '../../widgets/theme_toggle.dart';
import 'package:masjid_korea/l10n/app_localizations.dart';
import 'package:masjid_korea/presentation/pages/masjid_terdekat/masjid_terdekat.dart';
import 'package:masjid_korea/presentation/widgets/card/comunity_masjid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialCommunity});

  final String? initialCommunity;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _selectedFilters = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<MasjidCubit>().fetchMasjid();
  }

  void _onSearchChanged(String value) {
    // Debounce agar tidak men-trigger navigasi pada setiap ketikan
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      final query = value.trim();
      if (query.isEmpty) return;
      context.push('/search?q=${Uri.encodeComponent(query)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandTokens = theme.extension<BrandTokens>();
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/search?view=map'),
        icon: const Icon(Icons.map),
        label: Text(AppLocalizations.of(context).viewOnMap),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Hero Section
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 24 : 32,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.04),
                      theme.scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo dan language switcher (placeholder)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/logo_kmi.png',
                                  height: 32,
                                  semanticLabel: AppLocalizations.of(context).appLogoSemanticLabel,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context).appTitle,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            // TODO: Ganti dengan LanguageSwitcher dan ThemeToggle widgets
                            Row(
                              children: const [
                                LanguageSwitcher(),
                                SizedBox(width: 8),
                                ThemeToggle(),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        
                        // Heading utama
                        Text(
                          AppLocalizations.of(context).homeHeadline,
                          style: GoogleFonts.reemKufi(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context).homeSubtitle,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: brandTokens?.mutedText ?? Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: isMobile ? 24 : 32),
                        
                        // Search bar besar
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: isTablet ? 600 : double.infinity,
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).searchHint,
                              prefixIcon: const Icon(Icons.search, size: 24),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: _onSearchChanged,
                            onSubmitted: (value) {
                              final query = value.trim();
                              if (query.isNotEmpty) {
                                context.push('/search?q=${Uri.encodeComponent(query)}');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Filter chips
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: FilterChipsWidget(
                      selectedFilters: _selectedFilters,
                      onFiltersChanged: (filters) {
                        setState(() {
                          _selectedFilters = filters;
                        });
                        // TODO: Trigger filter masjid
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Section Masjid Terdekat
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: BlocBuilder<MasjidCubit, MasjidState>(
                      builder: (context, state) {
                        if (state is MasjidSuccess && state.masjid.isNotEmpty) {
                          return MasjidTerdekat(masjids: state.masjid);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
            
            // Section Komunitas Masjid
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: isMobile ? 16 : 24, right: isMobile ? 16 : 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: BlocBuilder<MasjidCubit, MasjidState>(
                      builder: (context, state) {
                        if (state is MasjidSuccess && state.masjid.isNotEmpty) {
                          return ComunityMasjid(masjid: state.masjid);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
            
            // Grid masjid
            BlocBuilder<MasjidCubit, MasjidState>(
              builder: (context, state) {
                if (state is MasjidLoading) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                      child: const SkeletonGridWidget(),
                    ),
                  );
                }
                
                if (state is MasjidFailed) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                      child: ErrorStateWidget(
                        message: state.error,
                        onRetry: () => context.read<MasjidCubit>().fetchMasjid(),
                      ),
                    ),
                  );
                }
                
                if (state is MasjidSuccess) {
                  var masjids = state.masjid;
                  // Jika datang dari /home?community=XYZ, filter daftar sesuai komunitas
                  final community = widget.initialCommunity;
                  if (community != null && community.isNotEmpty) {
                    masjids = masjids.where((m) => m.comunity == community).toList();
                  }
                   
                   if (masjids.isEmpty) {
                     return SliverToBoxAdapter(
                       child: EmptyStateWidget(
                        title: AppLocalizations.of(context).noData,
                        message: AppLocalizations.of(context).noDataMessage,
                      ),
                    );
                  }
                  
                  final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
                  
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: isMobile ? 3.2 : 1.15,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final masjid = masjids[index];
                          return MosqueCard(
                            masjid: masjid,
                            onTap: () {
                              context.push('/mosques/${masjid.id}');
                            },
                          );
                        },
                        childCount: masjids.length,
                      ),
                    ),
                  );
                }
                
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            
            // CTA Lihat dalam Peta
            SliverToBoxAdapter(
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
// Tambahkan FAB yang selalu terlihat untuk membuka tampilan peta
// Penempatan: tepat sebelum penutupan kelas Scaffold build (menggunakan FloatingActionButtonLocation.centerFloat)
// Catatan: Snippet ini harus ditambahkan ke properti Scaffold di metode build
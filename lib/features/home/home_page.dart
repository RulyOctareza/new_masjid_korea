// features/home/home_page.dart
// Tujuan: Halaman beranda dengan hero section, pencarian, filter chips, dan grid masjid.
// Cara pakai: Gunakan sebagai pengganti homepage lama jika ingin UI baru (saat ini belum diintegrasikan).
// Desain: Material 3 + Brand tokens, responsif (<600, 600-1024, >1024), aksesibilitas WCAG AA.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _selectedFilters = [];

  @override
  void initState() {
    super.initState();
    context.read<MasjidCubit>().fetchMasjid();
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
                        onSubmitted: (value) {
                          // TODO: Trigger pencarian
                        },
                      ),
                    ),
                  ],
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
                  final masjids = state.masjid;
                  
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
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.go('/search?view=map');
                    },
                    icon: const Icon(Icons.map),
                    label: Text(AppLocalizations.of(context).viewOnMap),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
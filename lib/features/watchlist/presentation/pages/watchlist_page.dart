import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/watchlist.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/bottom_nav_shell.dart';
import '../widgets/market_summary_card.dart';
import '../widgets/watchlist_stock_tile.dart';
import '../widgets/watchlist_tab_bar.dart';
import '../../../edit_watchlist/presentation/pages/edit_watchlist_page.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state.status != WatchlistStatus.loaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final selected = state.selectedWatchlist;
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  MarketSummaryCard(
                                    title: 'SENSEX 18TH SEP 8...',
                                    exchange: 'BSE',
                                    price: '1,225.55',
                                    change: '144.50 (13.36%)',
                                    isPositive: true,
                                    showContainer: false,
                                  ),
                                  SizedBox(
                                    height: 76,
                                    child: VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: AppColors.border,
                                    ),
                                  ),
                                  MarketSummaryCard(
                                    title: 'NIFTY BANK',
                                    exchange: '',
                                    price: '54,173.20',
                                    change: '-13.70 (-0.03%)',
                                    isPositive: false,
                                    changeBelowPrice: true,
                                    showContainer: false,
                                    showChevron: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                readOnly: true,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Search for instruments',
                                  prefixIcon: const Icon(
                                    Icons.search_rounded,
                                    color: AppColors.textSecondary,
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              WatchlistTabBar(
                                watchlists: state.watchlists,
                                selectedId: selected.id,
                                onTap: (watchlistId) {
                                  context.read<WatchlistBloc>().add(
                                    WatchlistSelected(watchlistId),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: FilledButton.tonalIcon(
                                      onPressed: () =>
                                          _openEditWatchlist(context, selected),
                                      icon: const Icon(
                                        Icons.tune_rounded,
                                        size: 18,
                                      ),
                                      label: const Text('Sort by'),
                                      style: FilledButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        backgroundColor: AppColors.surfaceMuted,
                                        foregroundColor: AppColors.textPrimary,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 2),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) => WatchlistStockTile(
                            key: ValueKey('stock-${selected.stocks[index].id}'),
                            stock: selected.stocks[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1, thickness: 1),
                          itemCount: selected.stocks.length,
                        ),
                      ),
                    ],
                  ),
                ),
                const BottomNavShell(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openEditWatchlist(
    BuildContext context,
    Watchlist watchlist,
  ) async {
    await Navigator.of(context).push(
      EditWatchlistPage.route(
        watchlist: watchlist,
        watchlistBloc: context.read<WatchlistBloc>(),
      ),
    );
  }
}

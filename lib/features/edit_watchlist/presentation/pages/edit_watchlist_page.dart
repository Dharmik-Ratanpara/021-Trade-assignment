import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../watchlist/domain/models/watchlist.dart';
import '../../../watchlist/presentation/bloc/watchlist_bloc.dart';
import '../cubit/edit_watchlist_cubit.dart';
import '../widgets/edit_watchlist_tile.dart';

class EditWatchlistPage extends StatelessWidget {
  const EditWatchlistPage({super.key, required this.watchlist});

  final Watchlist watchlist;

  static Route<Watchlist?> route({
    required Watchlist watchlist,
    required WatchlistBloc watchlistBloc,
  }) {
    return MaterialPageRoute<Watchlist?>(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: watchlistBloc),
          BlocProvider(create: (_) => EditWatchlistCubit(watchlist: watchlist)),
        ],
        child: EditWatchlistPage(watchlist: watchlist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWatchlistCubit, EditWatchlistState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        return PopScope(
          canPop: !state.isDirty,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop || !state.isDirty) {
              return;
            }
            final shouldDiscard = await _showDiscardDialog(context);
            if (shouldDiscard == true && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.surface,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  if (!state.isDirty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  final shouldDiscard = await _showDiscardDialog(context);
                  if (shouldDiscard == true && context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              title: Text(
                'Edit ${watchlist.title}',
                style: textTheme.headlineSmall?.copyWith(fontSize: 18),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: TextField(
                      controller: TextEditingController(text: state.draftTitle)
                        ..selection = TextSelection.collapsed(
                          offset: state.draftTitle.length,
                        ),
                      onChanged: context
                          .read<EditWatchlistCubit>()
                          .titleChanged,
                      decoration: InputDecoration(
                        hintText: 'Watchlist name',
                        suffixIcon: const Icon(
                          Icons.edit_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                      padding: EdgeInsets.zero,
                      buildDefaultDragHandles: false,
                      itemCount: state.draftStocks.length,
                      onReorder: context
                          .read<EditWatchlistCubit>()
                          .reorderStocks,
                      itemBuilder: (context, index) {
                        final stock = state.draftStocks[index];
                        return EditWatchlistTile(
                          key: ValueKey('edit-tile-${stock.id}'),
                          stock: stock,
                          index: index,
                          onDelete: () => context
                              .read<EditWatchlistCubit>()
                              .removeStock(stock.id),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      border: Border(top: BorderSide(color: AppColors.border)),
                    ),
                    child: Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            side: const BorderSide(color: AppColors.border),
                            foregroundColor: AppColors.textPrimary,
                            textStyle: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Edit other watchlists'),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: state.canSave
                              ? () {
                                  final updated = context
                                      .read<EditWatchlistCubit>()
                                      .state
                                      .draftWatchlist;
                                  context.read<WatchlistBloc>().add(
                                    WatchlistSaved(updated),
                                  );
                                  Navigator.of(context).pop(updated);
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.surface,
                            textStyle: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Save Watchlist'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool?> _showDiscardDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text('Your reordered watchlist has unsaved changes.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Keep editing'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );
  }
}

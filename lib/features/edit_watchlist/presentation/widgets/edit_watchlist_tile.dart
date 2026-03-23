import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../watchlist/domain/models/stock_quote.dart';

class EditWatchlistTile extends StatelessWidget {
  const EditWatchlistTile({
    super.key,
    required this.stock,
    required this.index,
    required this.onDelete,
  });

  final StockQuote stock;
  final int index;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: ValueKey(stock.id),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(
            Icons.drag_handle_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          stock.symbol,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}

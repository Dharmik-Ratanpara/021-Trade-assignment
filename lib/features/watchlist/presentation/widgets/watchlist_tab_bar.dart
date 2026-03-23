import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/watchlist.dart';

class WatchlistTabBar extends StatelessWidget {
  const WatchlistTabBar({
    super.key,
    required this.watchlists,
    required this.selectedId,
    required this.onTap,
  });

  final List<Watchlist> watchlists;
  final String selectedId;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 52,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final watchlist = watchlists[index];
            final selected = watchlist.id == selectedId;
            return GestureDetector(
              onTap: () => onTap(watchlist.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watchlist.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16.5,
                        color: selected
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 11),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 54,
                      height: 3,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.accent : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 30),
          itemCount: watchlists.length,
        ),
      ),
    );
  }
}

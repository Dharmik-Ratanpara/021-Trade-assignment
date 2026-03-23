import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class BottomNavShell extends StatelessWidget {
  const BottomNavShell({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const items = [
      (Icons.bookmark_border_rounded, 'Watchlist', true),
      (Icons.shopping_cart_outlined, 'Orders', false),
      (Icons.bolt_outlined, 'GTT+', false),
      (Icons.work_outline_rounded, 'Portfolio', false),
      (Icons.account_balance_wallet_outlined, 'Funds', false),
      (Icons.person_outline_rounded, 'Profile', false),
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.$1,
                        size: 23,
                        color: item.$3 ? AppColors.accent : AppColors.textMuted,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.$2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 10.5,
                          color: item.$3
                              ? AppColors.accent
                              : AppColors.textMuted,
                          fontWeight: item.$3
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

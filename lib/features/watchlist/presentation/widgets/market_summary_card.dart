import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MarketSummaryCard extends StatelessWidget {
  const MarketSummaryCard({
    super.key,
    required this.title,
    required this.exchange,
    required this.price,
    required this.change,
    required this.isPositive,
    this.changeBelowPrice = false,
    this.alignPriceRight = false,
    this.showContainer = true,
    this.showChevron = false,
  });

  final String title;
  final String exchange;
  final String price;
  final String change;
  final bool isPositive;
  final bool changeBelowPrice;
  final bool alignPriceRight;
  final bool showContainer;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = isPositive ? AppColors.positive : AppColors.negative;

    final content = Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (exchange.isNotEmpty)
                Text(
                  exchange,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (showChevron) ...[
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: alignPriceRight
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (changeBelowPrice) ...[
                const SizedBox(height: 3),
                Text(
                  change,
                  style: textTheme.bodySmall?.copyWith(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 2),
                Text(
                  change,
                  style: textTheme.bodySmall?.copyWith(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );

    return Expanded(
      child: showContainer
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.border),
              ),
              child: content,
            )
          : content,
    );
  }
}

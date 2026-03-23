import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/watchlist/data/watchlist_repository.dart';
import 'features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'features/watchlist/presentation/pages/watchlist_page.dart';

void main() {
  runApp(const TradeAssignmentApp());
}

class TradeAssignmentApp extends StatelessWidget {
  const TradeAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => const WatchlistRepository(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                WatchlistBloc(repository: context.read<WatchlistRepository>())
                  ..add(const WatchlistLoadRequested()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: '021 Trade Watchlist',
              theme: AppTheme.light,
              home: const WatchlistPage(),
            ),
          );
        },
      ),
    );
  }
}

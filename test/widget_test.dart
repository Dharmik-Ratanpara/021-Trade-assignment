import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trade_assignment/features/edit_watchlist/presentation/cubit/edit_watchlist_cubit.dart';
import 'package:trade_assignment/features/edit_watchlist/presentation/pages/edit_watchlist_page.dart';
import 'package:trade_assignment/features/watchlist/data/watchlist_repository.dart';
import 'package:trade_assignment/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:trade_assignment/features/watchlist/presentation/pages/watchlist_page.dart';

void main() {
  group('Watchlist flow', () {
    late WatchlistBloc bloc;

    setUp(() {
      bloc = WatchlistBloc(repository: const WatchlistRepository())
        ..add(const WatchlistLoadRequested());
    });

    tearDown(() => bloc.close());

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(value: bloc, child: const WatchlistPage()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders stock rows from state', (tester) async {
      await pumpApp(tester);

      expect(find.text('RELIANCE'), findsOneWidget);
      expect(find.text('HDFCBANK'), findsOneWidget);
    });

    testWidgets('edit page can reorder and save updated order', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Sort by'));
      await tester.pumpAndSettle();

      expect(find.text('Save Watchlist'), findsOneWidget);
      expect(find.text('HDFCBANK'), findsOneWidget);

      final reorderableList = tester.widget<ReorderableListView>(
        find.byType(ReorderableListView),
      );
      reorderableList.onReorder(0, 2);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save Watchlist'));
      await tester.pumpAndSettle();

      expect(
        bloc.state.selectedWatchlist.stocks.map((stock) => stock.id).take(2),
        ['asianpaint', 'hdfcbank'],
      );
    });

    testWidgets('save returns updated title to the watchlist screen', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.text('Sort by'));
      await tester.pumpAndSettle();

      final titleField = find.descendant(
        of: find.byType(EditWatchlistPage),
        matching: find.byType(TextField),
      );
      await tester.enterText(titleField, 'Momentum');
      await tester.pump();
      await tester.tap(find.text('Save Watchlist'));
      await tester.pumpAndSettle();

      expect(bloc.state.selectedWatchlist.title, 'Momentum');
    });
  });

  testWidgets('edit screen can be pumped directly', (tester) async {
    final watchlist = const WatchlistRepository().loadWatchlists().first;
    final bloc = WatchlistBloc(repository: const WatchlistRepository())
      ..add(const WatchlistLoadRequested());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
          BlocProvider(create: (_) => EditWatchlistCubit(watchlist: watchlist)),
        ],
        child: MaterialApp(home: EditWatchlistPage(watchlist: watchlist)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Edit Watchlist 1'), findsOneWidget);
  });
}

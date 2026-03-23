import 'package:flutter_test/flutter_test.dart';
import 'package:trade_assignment/features/edit_watchlist/presentation/cubit/edit_watchlist_cubit.dart';
import 'package:trade_assignment/features/watchlist/domain/models/stock_quote.dart';
import 'package:trade_assignment/features/watchlist/domain/models/watchlist.dart';

void main() {
  group('EditWatchlistCubit', () {
    late Watchlist watchlist;
    late EditWatchlistCubit cubit;

    setUp(() {
      watchlist = Watchlist(
        id: 'primary',
        title: 'Primary',
        stocks: const [
          StockQuote(
            id: 'a',
            symbol: 'AAA',
            subtitle: 'NSE | EQ',
            price: 100,
            change: 1,
            changePercent: 1,
          ),
          StockQuote(
            id: 'b',
            symbol: 'BBB',
            subtitle: 'NSE | EQ',
            price: 101,
            change: 1,
            changePercent: 1,
          ),
          StockQuote(
            id: 'c',
            symbol: 'CCC',
            subtitle: 'NSE | EQ',
            price: 102,
            change: 1,
            changePercent: 1,
          ),
        ],
      );
      cubit = EditWatchlistCubit(watchlist: watchlist);
    });

    tearDown(() => cubit.close());

    test('moves an item upward', () {
      cubit.reorderStocks(2, 0);

      expect(cubit.state.draftStocks.map((stock) => stock.id), ['c', 'a', 'b']);
    });

    test('moves an item downward', () {
      cubit.reorderStocks(0, 3);

      expect(cubit.state.draftStocks.map((stock) => stock.id), ['b', 'c', 'a']);
    });

    test('preserves all items after reorder', () {
      cubit.reorderStocks(1, 3);

      expect(cubit.state.draftStocks.length, 3);
      expect(cubit.state.draftStocks.map((stock) => stock.id).toSet(), {
        'a',
        'b',
        'c',
      });
    });

    test('deletes from the draft without mutating the source watchlist', () {
      cubit.removeStock('b');

      expect(cubit.state.draftStocks.map((stock) => stock.id), ['a', 'c']);
      expect(watchlist.stocks.map((stock) => stock.id), ['a', 'b', 'c']);
    });
  });
}

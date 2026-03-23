import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trade_assignment/features/watchlist/data/watchlist_repository.dart';
import 'package:trade_assignment/features/watchlist/presentation/bloc/watchlist_bloc.dart';

void main() {
  group('WatchlistBloc', () {
    late WatchlistBloc bloc;

    setUp(() {
      bloc = WatchlistBloc(repository: const WatchlistRepository());
    });

    tearDown(() => bloc.close());

    blocTest<WatchlistBloc, WatchlistState>(
      'loads sample watchlists',
      build: () => bloc,
      act: (bloc) => bloc.add(const WatchlistLoadRequested()),
      expect: () => [
        const WatchlistState(status: WatchlistStatus.loading),
        isA<WatchlistState>()
            .having((state) => state.status, 'status', WatchlistStatus.loaded)
            .having((state) => state.watchlists.isNotEmpty, 'watchlists', true),
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'saves a reordered watchlist into main state',
      build: () => bloc,
      seed: () {
        final watchlists = const WatchlistRepository().loadWatchlists();
        return WatchlistState(
          status: WatchlistStatus.loaded,
          watchlists: watchlists,
          selectedWatchlistId: watchlists.first.id,
        );
      },
      act: (bloc) {
        final current = bloc.state.selectedWatchlist;
        final reordered = current.copyWith(
          stocks: current.stocks.reversed.toList(),
        );
        bloc.add(WatchlistSaved(reordered));
      },
      expect: () => [
        isA<WatchlistState>().having(
          (state) => state.selectedWatchlist.stocks.first.id,
          'first stock id',
          const WatchlistRepository().loadWatchlists().first.stocks.last.id,
        ),
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'keeps main state unchanged when no save occurs',
      build: () => bloc,
      seed: () {
        final watchlists = const WatchlistRepository().loadWatchlists();
        return WatchlistState(
          status: WatchlistStatus.loaded,
          watchlists: watchlists,
          selectedWatchlistId: watchlists.first.id,
        );
      },
      act: (bloc) {},
      expect: () => <WatchlistState>[],
      verify: (bloc) {
        expect(bloc.state.selectedWatchlist.stocks.first.id, 'hdfcbank');
      },
    );
  });
}

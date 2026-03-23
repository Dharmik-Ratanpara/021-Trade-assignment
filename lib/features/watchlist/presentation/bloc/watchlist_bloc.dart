import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/watchlist_repository.dart';
import '../../domain/models/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({required WatchlistRepository repository})
    : _repository = repository,
      super(const WatchlistState()) {
    on<WatchlistLoadRequested>(_onLoadRequested);
    on<WatchlistSelected>(_onSelected);
    on<WatchlistSaved>(_onSaved);
  }

  final WatchlistRepository _repository;

  void _onLoadRequested(
    WatchlistLoadRequested event,
    Emitter<WatchlistState> emit,
  ) {
    emit(state.copyWith(status: WatchlistStatus.loading));
    final watchlists = _repository.loadWatchlists();
    emit(
      state.copyWith(
        status: WatchlistStatus.loaded,
        watchlists: watchlists,
        selectedWatchlistId: watchlists.first.id,
      ),
    );
  }

  void _onSelected(WatchlistSelected event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(selectedWatchlistId: event.watchlistId));
  }

  void _onSaved(WatchlistSaved event, Emitter<WatchlistState> emit) {
    final updated = state.watchlists
        .map(
          (watchlist) =>
              watchlist.id == event.watchlist.id ? event.watchlist : watchlist,
        )
        .toList(growable: false);

    emit(
      state.copyWith(
        watchlists: updated,
        selectedWatchlistId: event.watchlist.id,
      ),
    );
  }
}

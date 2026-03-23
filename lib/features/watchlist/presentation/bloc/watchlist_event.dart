part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

final class WatchlistLoadRequested extends WatchlistEvent {
  const WatchlistLoadRequested();
}

final class WatchlistSelected extends WatchlistEvent {
  const WatchlistSelected(this.watchlistId);

  final String watchlistId;

  @override
  List<Object?> get props => [watchlistId];
}

final class WatchlistSaved extends WatchlistEvent {
  const WatchlistSaved(this.watchlist);

  final Watchlist watchlist;

  @override
  List<Object?> get props => [watchlist];
}

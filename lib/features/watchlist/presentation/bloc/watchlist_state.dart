part of 'watchlist_bloc.dart';

enum WatchlistStatus { initial, loading, loaded }

class WatchlistState extends Equatable {
  const WatchlistState({
    this.status = WatchlistStatus.initial,
    this.watchlists = const [],
    this.selectedWatchlistId,
  });

  final WatchlistStatus status;
  final List<Watchlist> watchlists;
  final String? selectedWatchlistId;

  Watchlist get selectedWatchlist {
    final id = selectedWatchlistId;
    if (id == null) {
      return watchlists.first;
    }
    return watchlists.firstWhere((watchlist) => watchlist.id == id);
  }

  WatchlistState copyWith({
    WatchlistStatus? status,
    List<Watchlist>? watchlists,
    String? selectedWatchlistId,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      watchlists: watchlists ?? this.watchlists,
      selectedWatchlistId: selectedWatchlistId ?? this.selectedWatchlistId,
    );
  }

  @override
  List<Object?> get props => [status, watchlists, selectedWatchlistId];
}

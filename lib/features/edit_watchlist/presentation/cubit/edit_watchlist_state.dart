part of 'edit_watchlist_cubit.dart';

class EditWatchlistState extends Equatable {
  const EditWatchlistState({
    required this.initialWatchlist,
    required this.draftTitle,
    required this.draftStocks,
  });

  final Watchlist initialWatchlist;
  final String draftTitle;
  final List<StockQuote> draftStocks;

  bool get isDirty =>
      draftTitle != initialWatchlist.title ||
      draftStocks != initialWatchlist.stocks;

  bool get canSave => draftTitle.trim().isNotEmpty && draftStocks.isNotEmpty;

  Watchlist get draftWatchlist => initialWatchlist.copyWith(
    title: draftTitle.trim(),
    stocks: List<StockQuote>.unmodifiable(draftStocks),
  );

  EditWatchlistState copyWith({
    Watchlist? initialWatchlist,
    String? draftTitle,
    List<StockQuote>? draftStocks,
  }) {
    return EditWatchlistState(
      initialWatchlist: initialWatchlist ?? this.initialWatchlist,
      draftTitle: draftTitle ?? this.draftTitle,
      draftStocks: draftStocks ?? this.draftStocks,
    );
  }

  @override
  List<Object> get props => [initialWatchlist, draftTitle, draftStocks];
}

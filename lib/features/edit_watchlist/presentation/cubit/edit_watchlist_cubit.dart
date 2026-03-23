import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../watchlist/domain/models/stock_quote.dart';
import '../../../watchlist/domain/models/watchlist.dart';

part 'edit_watchlist_state.dart';

class EditWatchlistCubit extends Cubit<EditWatchlistState> {
  EditWatchlistCubit({required Watchlist watchlist})
    : super(
        EditWatchlistState(
          initialWatchlist: watchlist,
          draftTitle: watchlist.title,
          draftStocks: List<StockQuote>.from(watchlist.stocks),
        ),
      );

  void titleChanged(String value) {
    emit(state.copyWith(draftTitle: value));
  }

  void reorderStocks(int oldIndex, int newIndex) {
    final stocks = List<StockQuote>.from(state.draftStocks);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = stocks.removeAt(oldIndex);
    stocks.insert(newIndex, item);
    emit(state.copyWith(draftStocks: stocks));
  }

  void removeStock(String stockId) {
    final stocks = state.draftStocks
        .where((stock) => stock.id != stockId)
        .toList();
    emit(state.copyWith(draftStocks: stocks));
  }

  void reset() {
    emit(
      state.copyWith(
        draftTitle: state.initialWatchlist.title,
        draftStocks: List<StockQuote>.from(state.initialWatchlist.stocks),
      ),
    );
  }
}

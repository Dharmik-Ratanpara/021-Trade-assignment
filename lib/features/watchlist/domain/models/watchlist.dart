import 'package:equatable/equatable.dart';

import 'stock_quote.dart';

class Watchlist extends Equatable {
  const Watchlist({
    required this.id,
    required this.title,
    required this.stocks,
  });

  final String id;
  final String title;
  final List<StockQuote> stocks;

  Watchlist copyWith({String? id, String? title, List<StockQuote>? stocks}) {
    return Watchlist(
      id: id ?? this.id,
      title: title ?? this.title,
      stocks: stocks ?? this.stocks,
    );
  }

  @override
  List<Object> get props => [id, title, stocks];
}

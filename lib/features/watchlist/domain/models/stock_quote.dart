import 'package:equatable/equatable.dart';

class StockQuote extends Equatable {
  const StockQuote({
    required this.id,
    required this.symbol,
    required this.subtitle,
    required this.price,
    required this.change,
    required this.changePercent,
    this.priceDecimals = 2,
  });

  final String id;
  final String symbol;
  final String subtitle;
  final double price;
  final double change;
  final double changePercent;
  final int priceDecimals;

  StockQuote copyWith({
    String? id,
    String? symbol,
    String? subtitle,
    double? price,
    double? change,
    double? changePercent,
    int? priceDecimals,
  }) {
    return StockQuote(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      priceDecimals: priceDecimals ?? this.priceDecimals,
    );
  }

  @override
  List<Object> get props => [
    id,
    symbol,
    subtitle,
    price,
    change,
    changePercent,
    priceDecimals,
  ];
}

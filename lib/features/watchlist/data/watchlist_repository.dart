import '../domain/models/stock_quote.dart';
import '../domain/models/watchlist.dart';

class WatchlistRepository {
  const WatchlistRepository();

  List<Watchlist> loadWatchlists() {
    return const [
      Watchlist(
        id: 'watchlist-1',
        title: 'Watchlist 1',
        stocks: [
          StockQuote(
            id: 'hdfcbank',
            symbol: 'HDFCBANK',
            subtitle: 'NSE | EQ',
            price: 966.95,
            change: 0.95,
            changePercent: 0.10,
          ),
          StockQuote(
            id: 'asianpaint',
            symbol: 'ASIANPAINT',
            subtitle: 'NSE | EQ',
            price: 2537.40,
            change: 6.60,
            changePercent: 0.26,
          ),
          StockQuote(
            id: 'reliance',
            symbol: 'RELIANCE',
            subtitle: 'NSE | EQ',
            price: 1374.10,
            change: -4.40,
            changePercent: -0.32,
          ),
          StockQuote(
            id: 'nifty-it',
            symbol: 'NIFTY IT',
            subtitle: 'IDX',
            price: 35185.30,
            change: 874.86,
            changePercent: 2.55,
          ),
          StockQuote(
            id: 'reliance-1880-ce',
            symbol: 'RELIANCE SEP 1880 CE',
            subtitle: 'NSE | Monthly',
            price: 0.00,
            change: 0.00,
            changePercent: 0.00,
          ),
          StockQuote(
            id: 'reliance-1370-pe',
            symbol: 'RELIANCE SEP 1370 PE',
            subtitle: 'NSE | Monthly',
            price: 19.20,
            change: 1.00,
            changePercent: 5.49,
          ),
          StockQuote(
            id: 'mrf-nse',
            symbol: 'MRF',
            subtitle: 'NSE | EQ',
            price: 147625.00,
            change: 550.00,
            changePercent: 0.37,
          ),
          StockQuote(
            id: 'mrf-bse',
            symbol: 'MRF',
            subtitle: 'BSE | EQ',
            price: 147439.45,
            change: 463.80,
            changePercent: 0.32,
          ),
        ],
      ),
      Watchlist(
        id: 'watchlist-5',
        title: 'Watchlist 5',
        stocks: [
          StockQuote(
            id: 'tcs',
            symbol: 'TCS',
            subtitle: 'NSE | EQ',
            price: 4138.65,
            change: -12.20,
            changePercent: -0.29,
          ),
          StockQuote(
            id: 'icici',
            symbol: 'ICICIBANK',
            subtitle: 'NSE | EQ',
            price: 1220.50,
            change: 14.35,
            changePercent: 1.19,
          ),
          StockQuote(
            id: 'infosys',
            symbol: 'INFY',
            subtitle: 'NSE | EQ',
            price: 1760.20,
            change: 5.80,
            changePercent: 0.33,
          ),
        ],
      ),
      Watchlist(
        id: 'watchlist-6',
        title: 'Watchlist 6',
        stocks: [
          StockQuote(
            id: 'kotak',
            symbol: 'KOTAKBANK',
            subtitle: 'NSE | EQ',
            price: 1864.95,
            change: -6.25,
            changePercent: -0.33,
          ),
          StockQuote(
            id: 'sbicard',
            symbol: 'SBICARD',
            subtitle: 'NSE | EQ',
            price: 757.80,
            change: 9.10,
            changePercent: 1.22,
          ),
        ],
      ),
    ];
  }
}

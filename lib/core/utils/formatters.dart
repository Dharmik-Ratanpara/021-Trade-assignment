import 'package:intl/intl.dart';

final NumberFormat _standardNumberFormat = NumberFormat('#,##0.00');
final NumberFormat _compactChangeFormat = NumberFormat('#,##0.##');

String formatPrice(double value) => _standardNumberFormat.format(value);

String formatSignedChange(double value) {
  final formatted = _compactChangeFormat.format(value.abs());
  return value > 0
      ? '+$formatted'
      : value < 0
      ? '-$formatted'
      : formatted;
}

String formatPercent(double value) {
  final formatted = value.abs().toStringAsFixed(2);
  return value > 0
      ? '(+$formatted%)'
      : value < 0
      ? '(-$formatted%)'
      : '($formatted%)';
}

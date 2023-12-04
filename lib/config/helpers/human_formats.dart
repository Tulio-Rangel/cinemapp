import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);

    return formattedNumber;
  }

  static String date(DateTime date) {
    initializeDateFormatting('es'); //* Inicializa la localización en español
    final formattedDate = DateFormat('EEEE, d MMM', 'es').format(date);

    return formattedDate;
  }
}

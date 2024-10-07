import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

extension FormatCurrencyEx on dynamic {
  /// Format the input to VND currency format.
  String toVND() {
    int number = int.parse(toString());
    var vietNamFormatCurrency = NumberFormat.currency(locale: 'vi-VN', symbol: '');
    return vietNamFormatCurrency.format(number).trim().removeAllWhitespace;
  }
}

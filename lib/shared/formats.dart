

import 'package:flutter_masked_text/flutter_masked_text.dart';

String formatMoney(double price) {
  final lowPrice = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  ); //after
  lowPrice.updateValue(price);
  return lowPrice.text;
}

String formatPorcent(double value) {
  final lowValue = MoneyMaskedTextController(
      decimalSeparator: ',',
      rightSymbol: '%'
  ); //after
  lowValue.updateValue(value);
  return lowValue.text;
}
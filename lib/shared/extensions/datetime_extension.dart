// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String customToString() {
    DateFormat dateFormatterPtBr = DateFormat('dd/MM/yyyy');
    return dateFormatterPtBr.format(this);
  }

  String customYearToString() {
    DateFormat dateFormatterPtBr = DateFormat('yyyy-MM-dd');
    return dateFormatterPtBr.format(this);
  }

  String toStringWithHour() {
    DateFormat dateFormatterPtBr = DateFormat('yyyy/MM/dd hh:mm');
    return dateFormatterPtBr.format(this);
  }

  String customToStringWithHour() {
    DateFormat dateFormatterPtBr = DateFormat('dd/MM/yyyy HH:mm:ss',);
    return dateFormatterPtBr.format(this);
  }
}

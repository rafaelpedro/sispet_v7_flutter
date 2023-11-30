import 'package:intl/intl.dart';

class DataUtil {
  DataUtil._();

  static const _DATE_PTBR_FORMAT = 'dd/MM/yyyy';
  static const _DATE_US_FORMAT = 'yyyy-MM-dd';

  static DateTime convertStringToDate(String dateString) {
    final dateFormat = DateFormat(_DATE_PTBR_FORMAT);
    DateTime dateTime = dateFormat.parseStrict(dateString);
    return dateTime;
  }

  static String _formatDateTimeToCustomString(
      DateTime dateTime, String format) {
    final dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  static String convertDateTimeFromPTBR(DateTime date) {
    String dateStr = _formatDateTimeToCustomString(date, _DATE_PTBR_FORMAT);
    return dateStr;
  }

  static String convertDateTimeFromUS(DateTime date) {
    String dateStr = _formatDateTimeToCustomString(date, _DATE_US_FORMAT);
    return dateStr;
  }

  static String convertDateTimeForStringDate(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    String formattedDate = '$day/${month < 10 ? '0$month' : month}/$year';

    return formattedDate;
  }

  static String formatDateTimeToString(DateTime dateTime) {
    String formattedDate =
        '${dateTime.year}-${_formatNumber(dateTime.month)}-${_formatNumber(dateTime.day)} '
        '${_formatNumber(dateTime.hour)}:${_formatNumber(dateTime.minute)}:${_formatNumber(dateTime.second)}';
    return formattedDate;
  }

  static String _formatNumber(int number) {
  // Adiciona um zero à esquerda se o número for menor que 10
  return number.toString().padLeft(2, '0');
}
}

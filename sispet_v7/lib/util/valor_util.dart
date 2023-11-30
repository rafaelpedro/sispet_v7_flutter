class ValorUtil {
  ValorUtil._();

  static double convertStringToDouble(String value) {
    String cleanedValue = value.replaceAll('.', '');
    cleanedValue = cleanedValue.replaceAll(',', '.');
    return double.parse(cleanedValue);
  }

  static String convertDoubleToString(double value) {
    String stringValue = value.toString();

    List<String> parts = stringValue.split('.');

    String formattedValue = parts[0]
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )
        .trim();

    if (parts.length > 1) {
      formattedValue += ',${parts[1]}';
    }

    return formattedValue;
  }
}

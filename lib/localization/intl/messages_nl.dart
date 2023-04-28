import 'messages.dart';

/// The translations for Dutch Flemish (`nl`).
class FormBuilderLocalizationsImplNl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplNl([String locale = 'nl']) : super(locale);

  @override
  String get creditCardErrorText => 'Een geldig creditcardnummer is vereist.';

  @override
  String get dateStringErrorText => 'Een geldige datum is vereist.';

  @override
  String get emailErrorText => 'Een geldig e-mailadres is vereist.';

  @override
  String equalErrorText(Object value) {
    return 'De veldwaarde moet gelijk zijn aan $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Waarde moet een lengte hebben die gelijk is aan $length';
  }

  @override
  String get integerErrorText => 'Dit veld vereist een geheel getal. ';

  @override
  String get ipErrorText => 'Een geldig IP-adres is vereist.';

  @override
  String get matchErrorText => 'De waarde komt niet overeen met het patroon.';

  @override
  String maxErrorText(Object max) {
    return 'De waarde moet kleiner zijn dan of gelijk aan $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'De waarde moet een lengte hebben die kleiner is dan of gelijk is aan $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Waarde moet een woorden hebben die minder dan of gelijk is aan $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'De waarde moet groter zijn dan of gelijk aan $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'De waarde moet een lengte hebben die groter of gelijk is aan $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Waarde moet een woorden tellen groter dan of gelijk aan $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'De veldwaarde mag niet gelijk zijn aan $value.';
  }

  @override
  String get numericErrorText => 'De waarde moet numeriek zijn.';

  @override
  String get requiredErrorText => 'Dit veld mag niet leeg zijn.';

  @override
  String get urlErrorText => 'Een geldige URL is vereist.';
}

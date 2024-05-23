import 'messages.dart';

/// The translations for German (`de`).
class FormBuilderLocalizationsImplDe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplDe([String locale = 'de']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Für dieses Feld ist eine gültige Kreditkartennummer erforderlich.';

  @override
  String get dateStringErrorText => 'Dieses Feld erfordert ein gültiges Datum.';

  @override
  String get emailErrorText =>
      'Für dieses Feld ist eine gültige E-Mail-Adresse erforderlich.';

  @override
  String equalErrorText(Object value) {
    return 'Dieser Feldwert muss gleich $value sein.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Der Wert muss eine Länge von $length haben';
  }

  @override
  String get integerErrorText => 'Der Wert muss eine Ganze Zahl sein.';

  @override
  String get ipErrorText => 'Dieses Feld erfordert eine gültige IP-Adresse.';

  @override
  String get matchErrorText => 'Der Wert stimmt nicht mit dem Muster überein.';

  @override
  String maxErrorText(Object max) {
    return 'Der Wert muss kleiner oder gleich $max sein.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Der Wert muss eine Länge haben, die kleiner oder gleich $maxLength ist.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Der Wert muss eine Wortanzahl haben, die kleiner oder gleich $maxWordsCount ist.';
  }

  @override
  String minErrorText(Object min) {
    return 'Der Wert muss größer oder gleich $min sein.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Der Wert muss eine Länge haben, die größer oder gleich $minLength ist.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Der Wert muss eine Wortanzahl haben, die größer oder gleich $minWordsCount ist';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Dieser Feldwert darf nicht gleich $value sein.';
  }

  @override
  String get numericErrorText => 'Der Wert muss numerisch sein.';

  @override
  String get requiredErrorText => 'Dieses Feld darf nicht leer sein.';

  @override
  String get urlErrorText =>
      'Für dieses Feld ist eine gültige URL-Adresse erforderlich.';
}

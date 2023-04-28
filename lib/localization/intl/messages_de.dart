import 'messages.dart';

/// The translations for German (`de`).
class FormBuilderLocalizationsImplDe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplDe([String locale = 'de']) : super(locale);

  @override
  String get creditCardErrorText => 'Für dieses Feld ist eine gültige Kreditkartennummer erforderlich.';

  @override
  String get dateStringErrorText => 'Dieses Feld erfordert ein gültiges Datum.';

  @override
  String get emailErrorText => 'Für dieses Feld ist eine gültige E-Mail-Adresse erforderlich.';

  @override
  String equalErrorText(Object value) {
    return 'Dieser Feldwert muss $value gleich sein.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Der Wert muss eine Länge von haben $length';
  }

  @override
  String get integerErrorText => 'Der Wert muss eine integer sein.';

  @override
  String get ipErrorText => 'Dieses Feld erfordert eine gültige IP-Adresse.';

  @override
  String get matchErrorText => 'Der Wert stimmt nicht mit dem Muster überein.';

  @override
  String maxErrorText(Object max) {
    return 'Der Wert muss kleiner als oder gleich $max sein.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Der Wert muss eine Länge kleiner als oder gleich $maxLength haben.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Der Wert muss eine Wörter weniger als oder gleich $maxWordsCount zählen lassen';
  }

  @override
  String minErrorText(Object min) {
    return 'Der Wert muss größer als oder gleich $min sein.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Der Wert muss eine Länge größer als oder gleich $minLength haben.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Der Wert muss eine Wörter haben, die größer oder gleich $minWordsCount ist';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Dieser Feldwert darf nicht gleich sein $value.';
  }

  @override
  String get numericErrorText => 'Der Wert muss numerisch sein.';

  @override
  String get requiredErrorText => 'Dieses Feld kann nicht leer sein.';

  @override
  String get urlErrorText => 'Für dieses Feld ist eine gültige URL-Adresse erforderlich.';
}

import 'messages.dart';

/// The translations for German (`de`).
class FormBuilderLocalizationsImplDe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplDe([String locale = 'de']) : super(locale);

  @override
  String get requiredErrorText => 'Dieses Feld kann nicht leer sein.';

  @override
  String minErrorText(Object min) {
    return 'Der Wert muss größer als oder gleich $min sein.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Der Wert muss eine Länge größer als oder gleich $minLength haben.';
  }

  @override
  String maxErrorText(Object max) {
    return 'Der Wert muss kleiner als oder gleich $max sein.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Der Wert muss eine Länge kleiner als oder gleich $maxLength haben.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'Für dieses Feld ist eine gültige E-Mail-Adresse erforderlich.';

  @override
  String get integerErrorText => 'Der Wert muss eine integer sein.';

  @override
  String equalErrorText(Object value) {
    return 'Dieser Feldwert muss $value gleich sein.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'This field value must not be equal to $value.';
  }

  @override
  String get urlErrorText => 'Für dieses Feld ist eine gültige URL-Adresse erforderlich.';

  @override
  String get matchErrorText => 'Der Wert stimmt nicht mit dem Muster überein.';

  @override
  String get numericErrorText => 'Der Wert muss numerisch sein.';

  @override
  String get creditCardErrorText => 'Für dieses Feld ist eine gültige Kreditkartennummer erforderlich.';

  @override
  String get ipErrorText => 'Dieses Feld erfordert eine gültige IP-Adresse.';

  @override
  String get dateStringErrorText => 'Dieses Feld erfordert ein gültiges Datum.';
}

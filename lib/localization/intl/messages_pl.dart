import 'messages.dart';

/// The translations for Polish (`pl`).
class FormBuilderLocalizationsImplPl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplPl([String locale = 'pl']) : super(locale);

  @override
  String get requiredErrorText => 'To pole nie może być puste.';

  @override
  String minErrorText(Object min) {
    return 'Wartość musi być większa lub równa $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Wartość musi mieć co najmniej $minLength znaków.';
  }

  @override
  String maxErrorText(Object max) {
    return 'Wartość musi być mniejsza lub równa $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Wartość nie może mieć więcej niż $maxLength znaków.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'To pole wymaga prawidłowego adresu e-mail.';

  @override
  String get integerErrorText => 'Wartość musi być liczbą całkowitą.';

  @override
  String equalErrorText(Object value) {
    return 'Wartość tego pola musi wynosić $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Wartość tego pola nie może być $value.';
  }

  @override
  String get urlErrorText => 'To pole wymaga prawidłowego adresu URL.';

  @override
  String get matchErrorText => 'Wartość nie pasuje do oczekiwanego kształtu.';

  @override
  String get numericErrorText => 'Wartość musi być liczbą.';

  @override
  String get creditCardErrorText => 'To pole wymaga podania ważnego numeru karty kredytowej.';

  @override
  String get ipErrorText => 'To pole wymaga prawidłowego adresu IP.';

  @override
  String get dateStringErrorText => 'To pole wymaga prawidłowej daty.';
}

import 'messages.dart';

/// The translations for Polish (`pl`).
class FormBuilderLocalizationsImplPl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplPl([String locale = 'pl']) : super(locale);

  @override
  String get creditCardErrorText =>
      'To pole wymaga podania ważnego numeru karty kredytowej.';

  @override
  String get dateStringErrorText => 'To pole wymaga prawidłowej daty.';

  @override
  String get emailErrorText => 'To pole wymaga prawidłowego adresu e-mail.';

  @override
  String equalErrorText(Object value) {
    return 'Wartość tego pola musi wynosić $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Wartość musi mieć długość równą $length';
  }

  @override
  String get integerErrorText => 'Wartość musi być liczbą całkowitą.';

  @override
  String get ipErrorText => 'To pole wymaga prawidłowego adresu IP.';

  @override
  String get matchErrorText => 'Wartość nie pasuje do oczekiwanego kształtu.';

  @override
  String maxErrorText(Object max) {
    return 'Wartość musi być mniejsza lub równa $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Wartość nie może mieć więcej niż $maxLength znaków.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Wartość musi mieć liczbę słów mniejszych lub równych $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Wartość musi być większa lub równa $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Wartość musi mieć co najmniej $minLength znaków.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Wartość musi mieć liczbę słów większą lub równą $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Wartość tego pola nie może być $value.';
  }

  @override
  String get numericErrorText => 'Wartość musi być liczbą.';

  @override
  String get requiredErrorText => 'To pole nie może być puste.';

  @override
  String get urlErrorText => 'To pole wymaga prawidłowego adresu URL.';
}

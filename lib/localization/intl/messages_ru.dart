import 'messages.dart';

/// The translations for Russian (`ru`).
class FormBuilderLocalizationsImplRu extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplRu([String locale = 'ru']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Значение поля должно быть номером кредитной карты.';

  @override
  String get dateStringErrorText => 'Поле должно быть датой.';

  @override
  String get emailErrorText => 'Поле должно быть email адресом.';

  @override
  String equalErrorText(Object value) {
    return 'Значение поля должно быть равно $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Значение должно иметь длину, равную $length';
  }

  @override
  String get integerErrorText => 'Поле должно быть целым числом.';

  @override
  String get ipErrorText => 'Поле должно быть IP номером.';

  @override
  String get matchErrorText => 'Значение должно удовлетворять шаблону.';

  @override
  String maxErrorText(Object max) {
    return 'Значение должно быть меньше или равно $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Длина значения должно быть меньше или равно $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Значение должно иметь слов, что меньше или равно $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Значение должно быть больше или равно $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Длина значения должно быть больше или равно $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Значение должно иметь слов, больше или равно $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Значение поля не должно быть равным $value.';
  }

  @override
  String get numericErrorText => 'Значение должно быть числом.';

  @override
  String get requiredErrorText => 'Поле не может быть пустым.';

  @override
  String get urlErrorText => 'Поле должно быть URL адресом.';
}

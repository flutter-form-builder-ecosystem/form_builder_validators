import 'messages.dart';

/// The translations for Russian (`ru`).
class FormBuilderLocalizationsImplRu extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplRu([String locale = 'ru']) : super(locale);

  @override
  String get requiredErrorText => 'Поле не может быть пустым.';

  @override
  String minErrorText(Object min) {
    return 'Значение должно быть больше или равно $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Длина значения должно быть больше или равно $minLength.';
  }

  @override
  String maxErrorText(Object max) {
    return 'Значение должно быть меньше или равно $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Длина значения должно быть меньше или равно $maxLength.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'Поле должно быть email адресом.';

  @override
  String get integerErrorText => 'Поле должно быть целым числом.';

  @override
  String equalErrorText(Object value) {
    return 'Значение поля должно быть равно $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Значение поля не должно быть равным $value.';
  }

  @override
  String get urlErrorText => 'Поле должно быть URL адресом.';

  @override
  String get matchErrorText => 'Значение должно удовлетворять шаблону.';

  @override
  String get numericErrorText => 'Значение должно быть числом.';

  @override
  String get creditCardErrorText => 'Значение поля должно быть номером кредитной карты.';

  @override
  String get ipErrorText => 'Поле должно быть IP номером.';

  @override
  String get dateStringErrorText => 'Поле должно быть датой.';
}

import 'messages.dart';

/// The translations for Ukrainian (`uk`).
class FormBuilderLocalizationsImplUk extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplUk([String locale = 'uk']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Значення поля має бути номером кредитної картки.';

  @override
  String get dateStringErrorText => 'Поле має бути датою.';

  @override
  String get emailErrorText => 'Поле має бути email адрес.';

  @override
  String equalErrorText(Object value) {
    return 'Значення поля має дорівнювати $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Значення повинно мати довжину, рівну $length';
  }

  @override
  String get integerErrorText => 'Поле має бути цілим числом.';

  @override
  String get ipErrorText => 'Поле має бути IP номером.';

  @override
  String get matchErrorText => 'Значення має задовольняти шаблоном.';

  @override
  String maxErrorText(Object max) {
    return 'Значення має бути менше або дорівнює $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Довжина значеня Має бути менше або дорівнює $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Значення повинно мати слова врахувати менше або дорівнює $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Значення має бути більш або дорівнює $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Довжина значеня Має бути більш або дорівнює $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Значення повинно мати слова врахувати більше або дорівнює $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Значення поля не повинно бути рівним $value.';
  }

  @override
  String get numericErrorText => 'Значення має бути числом.';

  @override
  String get requiredErrorText => 'Поле не може бути порожнім.';

  @override
  String get urlErrorText => 'Поле має бути URL адресою.';
}

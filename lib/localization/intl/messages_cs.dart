import 'messages.dart';

/// The translations for Czech (`cs`).
class FormBuilderLocalizationsImplCs extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplCs([String locale = 'cs']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Pole vyžaduje platné číslo kreditní karty.';

  @override
  String get dateStringErrorText => 'Pole vyžaduje platný zápis data.';

  @override
  String get emailErrorText => 'Pole vyžaduje platnou e-mailovou adresu.';

  @override
  String equalErrorText(Object value) {
    return 'Hodnota se musí rovnat $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Hodnota musí mít délku rovnu $length';
  }

  @override
  String get integerErrorText => 'Hodnota musí být celé číslo.';

  @override
  String get ipErrorText => 'Pole vyžaduje platnou IP adresu.';

  @override
  String get matchErrorText => 'Hodnota neodpovídá vzoru.';

  @override
  String maxErrorText(Object max) {
    return 'Hodnota musí být menší než nebo rovna $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Hodnota musí mít délku menší než nebo rovnu $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Hodnota musí mít počet slov menší nebo rovná $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Hodnota musí být větší než nebo rovna $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Hodnota musí mít délku větší než nebo rovnu $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Hodnota musí mít počet slov větší nebo rovná $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Hodnota se nesmí rovnat $value.';
  }

  @override
  String get numericErrorText => 'Hodnota musí být číslo.';

  @override
  String get requiredErrorText => 'Pole nemůže být prázdné.';

  @override
  String get urlErrorText => 'Pole vyžaduje platnou adresu URL.';
}

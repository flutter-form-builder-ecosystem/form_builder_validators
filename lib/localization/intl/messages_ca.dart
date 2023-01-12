import 'messages.dart';

/// The translations for Catalan Valencian (`ca`).
class FormBuilderLocalizationsImplCa extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplCa([String locale = 'ca']) : super(locale);

  @override
  String get requiredErrorText => 'Aquest camp no pot estar buit.';

  @override
  String minErrorText(Object min) {
    return 'El valor ha de ser superior o igual a $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'El valor ha de tenir una longitud superior o igual a $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'El valor ha de tenir un compte de paraules superior o igual a $minWordsCount';
  }

  @override
  String maxErrorText(Object max) {
    return 'El valor ha de ser inferior o igual a $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'El valor ha de tenir una longitud inferior o igual a $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'El valor ha de tenir un compte de paraules inferior o igual a $maxWordsCount';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'Aquest camp requereix una adreça de correu electrònic vàlida.';

  @override
  String get integerErrorText => 'Aquest camp requereix un nombre enter vàlid.';

  @override
  String equalErrorText(Object value) {
    return 'Aquest valor de camp ha de ser igual a $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Aquest valor de camp no ha de ser igual a $value.';
  }

  @override
  String get urlErrorText => 'Aquest camp requereix una adreça URL vàlida.';

  @override
  String get matchErrorText => 'El valor no coincideix amb el patró.';

  @override
  String get numericErrorText => 'El valor ha de ser numèric.';

  @override
  String get creditCardErrorText => 'Aquest camp requereix un número de targeta de crèdit vàlid.';

  @override
  String get ipErrorText => 'Aquest camp requereix una IP vàlida.';

  @override
  String get dateStringErrorText => 'Aquest camp requereix una cadena de data vàlida.';
}

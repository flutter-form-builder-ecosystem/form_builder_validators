import 'messages.dart';

/// The translations for Portuguese (`pt`).
class FormBuilderLocalizationsImplPt extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplPt([String locale = 'pt']) : super(locale);

  @override
  String get requiredErrorText => 'Este campo não pode ficar vazio.';

  @override
  String minErrorText(Object min) {
    return 'O valor deve ser maior ou igual a $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'O valor deve ter um comprimento maior ou igual a $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'O valor deve ser menor ou igual a $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'O valor deve ter um comprimento menor ou igual a $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'O valor deve ter um comprimento igual a $length';
  }

  @override
  String get emailErrorText => 'Este campo requer um endereço de e-mail válido.';

  @override
  String get integerErrorText => 'This field requires a valid integer.';

  @override
  String equalErrorText(Object value) {
    return 'This field value must be equal to $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'This field value must not be equal to $value.';
  }

  @override
  String get urlErrorText => 'Este campo requer um endereço de URL válido.';

  @override
  String get matchErrorText => 'O valor não corresponde ao padrão.';

  @override
  String get numericErrorText => 'O valor deve ser numérico.';

  @override
  String get creditCardErrorText => 'Este campo requer um número de cartão de crédito válido.';

  @override
  String get ipErrorText => 'Este campo requer um IP válido.';

  @override
  String get dateStringErrorText => 'Este campo requer uma string de data válida.';
}

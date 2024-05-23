import 'messages.dart';

/// The translations for Spanish Castilian (`es`).
class FormBuilderLocalizationsImplEs extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplEs([String locale = 'es']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Este campo requiere un número de tarjeta de crédito válido.';

  @override
  String get dateStringErrorText =>
      'Este campo requiere una cadena de fecha válida.';

  @override
  String get emailErrorText =>
      'Este campo requiere una dirección de correo electrónico válida.';

  @override
  String equalErrorText(Object value) {
    return 'Este campo debe ser igual a $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'El valor debe tener una longitud igual a $length';
  }

  @override
  String get integerErrorText => 'Este campo requiere un entero válido.';

  @override
  String get ipErrorText => 'Este campo requiere una IP válida.';

  @override
  String get matchErrorText => 'El valor no coincide con el patrón requerido.';

  @override
  String maxErrorText(Object max) {
    return 'El valor debe ser menor o igual que $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'El valor debe tener una longitud menor o igual a $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'El valor debe tener un recuento de palabras menos o igual a $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'El valor debe ser mayor o igual que $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'El valor debe tener una longitud mayor o igual a $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'El valor debe tener un recuento de palabras mayor o igual a $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Este campo no debe ser igual a $value.';
  }

  @override
  String get numericErrorText => 'El valor debe ser numérico.';

  @override
  String get requiredErrorText => 'Este campo no puede estar vacío.';

  @override
  String get urlErrorText => 'Este campo requiere una dirección URL válida.';
}

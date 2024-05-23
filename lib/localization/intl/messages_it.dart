import 'messages.dart';

/// The translations for Italian (`it`).
class FormBuilderLocalizationsImplIt extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplIt([String locale = 'it']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Questo campo richiede un numero di carta di credito valido.';

  @override
  String get dateStringErrorText => 'Questo campo richiede una data valida.';

  @override
  String get emailErrorText =>
      'Questo campo richiede un indirizzo email valido.';

  @override
  String equalErrorText(Object value) {
    return 'Il valore di questo campo deve essere uguale a $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Il valore deve avere una lunghezza uguale a $length';
  }

  @override
  String get integerErrorText => 'Il valore deve essere un integer.';

  @override
  String get ipErrorText => 'Questo campo richiede un indirizzo IP valido.';

  @override
  String get matchErrorText =>
      'Il valore non corrisponde al formato richiesto.';

  @override
  String maxErrorText(Object max) {
    return 'Il valore inserito deve essere minore o uguale a $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Il valore inserito deve avere una lunghezza minore o uguale a $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Il valore deve avere un conteggio di parole inferiore o uguale a $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Il valore inserito deve essere maggiore o uguale a $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Il valore inserito deve avere una lunghezza maggiore o uguale a $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Il valore deve avere un conteggio di parole maggiore o uguale a $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Questo valore di campo non deve essere uguale a $value.';
  }

  @override
  String get numericErrorText => 'Il valore deve essere numerico.';

  @override
  String get requiredErrorText => 'Questo campo non può essere vuoto.';

  @override
  String get urlErrorText => 'Questo campo richiede una URL valida.';
}

import 'messages.dart';

/// The translations for Danish (`da`).
class FormBuilderLocalizationsImplDa extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplDa([String locale = 'da']) : super(locale);

  @override
  String get creditCardErrorText => 'Dette felt kræver et gyldigt kreditkort nummer.';

  @override
  String get dateStringErrorText => 'Dette felt kræver en gyldig dato.';

  @override
  String get emailErrorText => 'Dette felt kræver en gyldig e-mail adresse.';

  @override
  String equalErrorText(Object value) {
    return 'Dette felts værdi skal være lig med $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Værdiens længde skal være lig med $length';
  }

  @override
  String get integerErrorText => 'Værdien skal være et heltal.';

  @override
  String get ipErrorText => 'Dette felt kræver en gyldig IP.';

  @override
  String get matchErrorText => 'Værdien matcher ikke mønstret.';

  @override
  String maxErrorText(Object max) {
    return 'Værdien skal være mindre eller lig med $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Værdiens længde skal være mindre eller lig med $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Værdiens antal af ord skal være mindre eller lig med $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Værdien skal være større end eller lig med $min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Værdien skal være større end eller lig med $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Antallet af ord skal være større eller lig med $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Feltets værdi må ikke være lig med $value.';
  }

  @override
  String get numericErrorText => 'Værdien skal være numerisk.';

  @override
  String get requiredErrorText => 'Feltet skal udfyldes.';

  @override
  String get urlErrorText => 'Skal være en gyldig URL adresse.';
}

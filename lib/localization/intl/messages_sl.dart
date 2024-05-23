import 'messages.dart';

/// The translations for Slovenian (`sl`).
class FormBuilderLocalizationsImplSl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplSl([String locale = 'sl']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Vnesite veljavno številko kreditne kartice.';

  @override
  String get dateStringErrorText => 'Vnesite veljaven datum.';

  @override
  String get emailErrorText => 'Vnesite veljaven e-mail naslov.';

  @override
  String equalErrorText(Object value) {
    return 'Vrednost mora biti enaka $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Besedilo mora biti dolgo $length znakov.';
  }

  @override
  String get integerErrorText => 'Vnesite celo število.';

  @override
  String get ipErrorText => 'Vnesite veljaven IP naslov.';

  @override
  String get matchErrorText => 'Vrednost ne ustreza predpisanemu vzorcu.';

  @override
  String maxErrorText(Object max) {
    return 'Vrednost ne sme presegati $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Besedilo mora biti krajše ali enako $maxLength znakov.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Vrednost mora imeti besede manj kot ali enake $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Vrednost mora biti večja ali enaka $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Besedilo mora biti daljše ali enako $minLength znakov.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Vrednost mora imeti besede, ki so večje ali enake $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Vrednost ne sme biti enaka $value.';
  }

  @override
  String get numericErrorText => 'Vrednost polja mora biti numerična.';

  @override
  String get requiredErrorText => 'Polje ne sme biti prazno.';

  @override
  String get urlErrorText => 'Vnesite veljaven URL naslov.';
}

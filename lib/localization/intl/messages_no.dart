import 'messages.dart';

/// The translations for Norwegian (`no`).
class FormBuilderLocalizationsImplNo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplNo([String locale = 'no']) : super(locale);

  @override
  String get creditCardErrorText => 'Dette feltet krever et gyldig kredittkortnummer.';

  @override
  String get dateStringErrorText => 'Dette feltet krever en gyldig dato.';

  @override
  String get emailErrorText => 'Dette feltet krever en gyldig e-postadresse.';

  @override
  String equalErrorText(Object value) {
    return 'Verdien i dette feltet må være lik $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Verdien må ha lengden $length.';
  }

  @override
  String get integerErrorText => 'Verdien må være et heltall.';

  @override
  String get ipErrorText => 'Dette feltet krever en gyldig IP-adresse.';

  @override
  String get matchErrorText => 'Verdien samsvarer ikke med mønsteret.';

  @override
  String maxErrorText(Object max) {
    return 'Verdien må være mindre enn eller lik $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Verdien må være mindre enn eller lik $maxLength tegn.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Antall ord må være mindre enn eller lik $maxWordsCount.';
  }

  @override
  String minErrorText(Object min) {
    return 'Verdien må være større enn eller lik $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Verdien må være større enn eller lik $minLength tegn.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Antall ord må være større enn eller lik $minWordsCount.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Verdien i feltet må ikke være lik $value.';
  }

  @override
  String get numericErrorText => 'Verdien må være numerisk.';

  @override
  String get requiredErrorText => 'Dette feltet må fylles ut.';

  @override
  String get urlErrorText => 'Må være en gyldig URL-adresse.';
}

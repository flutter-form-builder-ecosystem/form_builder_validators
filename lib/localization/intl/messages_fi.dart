import 'messages.dart';

/// The translations for Finnish (`fi`).
class FormBuilderLocalizationsImplFi extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplFi([String locale = 'fi']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Luottokortonumero on oltava oikeassa muodossa.';

  @override
  String get dateStringErrorText => 'Päivämäärä ei ole oikessa muodossa.';

  @override
  String get emailErrorText => 'Sähköpostiosoitteen muoto ei ole oikea.';

  @override
  String equalErrorText(Object value) {
    return 'Kentän vastattava arvoa $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Merkkijonon pituus on oltava $length';
  }

  @override
  String get integerErrorText => 'Tarvitaan voimassa olevan kokonaisluku.';

  @override
  String get ipErrorText => 'IP-osoitteen nuoto on annettava oikein.';

  @override
  String get matchErrorText => 'Arvo ei vastaa muotovaatimuksia.';

  @override
  String maxErrorText(Object max) {
    return 'Arvon tulee olla pienempi tai yhtä suuri kuin $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Merkkijonon pituuden tulee olla pienempi tai yhtä suuri kuin $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Sanamäärän tulee olla pienempi tai yhtä suuri kuin $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Kentän arvon tulee olla suurempi tai yhtä suuri kuin $min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Merkkijonon pituuden tulee olla suurempi tai yhtä suuri kuin $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Sanamäärän tulee olla suurempi tai yhtä suuri kuin $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Tämän kentän arvo ei saa olla sama kuin $value.';
  }

  @override
  String get numericErrorText => 'Arvon tulee olla numeerinen.';

  @override
  String get requiredErrorText => 'Kenttä ei voi olla tyhjä.';

  @override
  String get urlErrorText => 'Vaaditaan oikean muotoinen URL-osoite.';
}

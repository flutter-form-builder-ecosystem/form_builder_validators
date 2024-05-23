import 'messages.dart';

/// The translations for French (`fr`).
class FormBuilderLocalizationsImplFr extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplFr([String locale = 'fr']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Ce champ nécessite un numéro de carte de crédit valide.';

  @override
  String get dateStringErrorText =>
      'Ce champ nécessite une chaîne de date valide.';

  @override
  String get emailErrorText => 'Ce champ nécessite une adresse e-mail valide.';

  @override
  String equalErrorText(Object value) {
    return 'Cette valeur de champ doit être égale à $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'La valeur doit avoir une longueur égale à $length';
  }

  @override
  String get integerErrorText => 'Ce champ nécessite un entier valide.';

  @override
  String get ipErrorText => 'Ce champ nécessite une adresse IP valide.';

  @override
  String get matchErrorText => 'La valeur ne correspond pas au modèle.';

  @override
  String maxErrorText(Object max) {
    return 'La valeur doit être inférieure ou égale à $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'La valeur doit avoir une longueur inférieure ou égale à $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'La valeur doit avoir un nombre de mots inférieur ou égal à $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'La valeur doit être supérieure ou égale à $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'La valeur doit avoir une longueur supérieure ou égale à $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'La valeur doit avoir un nombre de mots supérieur ou égal à $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Cette valeur de champ ne doit pas être égale à $value.';
  }

  @override
  String get numericErrorText => 'La valeur doit être numérique.';

  @override
  String get requiredErrorText => 'Ce champ ne peut pas être vide.';

  @override
  String get urlErrorText => 'Ce champ nécessite une adresse URL valide.';
}

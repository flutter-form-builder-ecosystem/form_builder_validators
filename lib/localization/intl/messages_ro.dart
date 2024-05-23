import 'messages.dart';

/// The translations for Romanian Moldavian Moldovan (`ro`).
class FormBuilderLocalizationsImplRo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplRo([String locale = 'ro']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Acest câmp necesită un număr valid de card de credit.';

  @override
  String get dateStringErrorText => 'Acest câmp necesită un șir de date valid.';

  @override
  String get emailErrorText => 'Acest câmp necesită o adresă de e-mail validă.';

  @override
  String equalErrorText(Object value) {
    return 'Valoarea câmpului trebuie să fie egală cu $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Valoarea trebuie să aibă o lungime egală cu $length';
  }

  @override
  String get integerErrorText => 'Acest câmp necesită un număr întreg valid.';

  @override
  String get ipErrorText => 'Acest câmp necesită un IP valid.';

  @override
  String get matchErrorText => 'Valoarea nu se potrivește cu modelul.';

  @override
  String maxErrorText(Object max) {
    return 'Valoarea trebuie să fie mai mică sau egală cu $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Valoarea trebuie să aibă o lungime mai mică sau egală cu $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Valoarea trebuie să aibă un număr de cuvinte mai mic sau egal cu $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Valoarea trebuie să fie mai mare sau egală cu $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Valoarea trebuie să aibă o lungime mai mare sau egală cu $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Valoarea trebuie să aibă un număr de cuvinte mai mare sau egal cu $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Valoarea câmpului nu trebuie să fie egală cu $value.';
  }

  @override
  String get numericErrorText => 'Valoarea trebuie să fie numerică.';

  @override
  String get requiredErrorText => 'Acest câmp nu poate fi gol.';

  @override
  String get urlErrorText => 'Acest câmp necesită o adresă URL validă.';
}

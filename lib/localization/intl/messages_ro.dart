import 'messages.dart';

/// The translations for Romanian Moldavian Moldovan (`ro`).
class FormBuilderLocalizationsImplRo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplRo([String locale = 'ro']) : super(locale);

  @override
  String get requiredErrorText => 'Acest câmp nu poate fi gol.';

  @override
  String minErrorText(Object min) {
    return 'Valoarea trebuie să fie mai mare sau egală cu $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Valoarea trebuie să aibă o lungime mai mare sau egală cu $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'Valoarea trebuie să fie mai mică sau egală cu $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Valoarea trebuie să aibă o lungime mai mică sau egală cu $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'Acest câmp necesită o adresă de e-mail validă.';

  @override
  String get integerErrorText => 'Acest câmp necesită un număr întreg valid.';

  @override
  String equalErrorText(Object value) {
    return 'Valoarea câmpului trebuie să fie egală cu $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Valoarea câmpului nu trebuie să fie egală cu $value.';
  }

  @override
  String get urlErrorText => 'Acest câmp necesită o adresă URL validă.';

  @override
  String get matchErrorText => 'Valoarea nu se potrivește cu modelul.';

  @override
  String get numericErrorText => 'Valoarea trebuie să fie numerică.';

  @override
  String get creditCardErrorText => 'Acest câmp necesită un număr valid de card de credit.';

  @override
  String get ipErrorText => 'Acest câmp necesită un IP valid.';

  @override
  String get dateStringErrorText => 'Acest câmp necesită un șir de date valid.';
}

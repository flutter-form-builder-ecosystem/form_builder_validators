import 'messages.dart';

/// The translations for Hungarian (`hu`).
class FormBuilderLocalizationsImplHu extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplHu([String locale = 'hu']) : super(locale);

  @override
  String get requiredErrorText => 'Ennek a mezőnek értéket kell adni.';

  @override
  String minErrorText(Object min) {
    return 'Az érték legyen legalább $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Az értéknel legalább $minLength karakter hosszúnak kell lennie';
  }

  @override
  String maxErrorText(Object max) {
    return 'Az érték legyen legfeljebb $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Value must have a length less than or equal to $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'A megadott érték nem egy érvényes email cím.';

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
  String get urlErrorText => 'A megadott érték nem egy érvényes URL cím.';

  @override
  String get matchErrorText => 'A megadott érték nem egyezik a szükséges formátummal.';

  @override
  String get numericErrorText => 'Ebbe a mezőbe csak számot lehet írni.';

  @override
  String get creditCardErrorText => 'A megadott érték nem egy érvényes bankkártya szám.';

  @override
  String get ipErrorText => 'A megadott érték nem egy érvényes IP cím.';

  @override
  String get dateStringErrorText => 'Ennek a mezőnek dátumnak kell lennie.';
}

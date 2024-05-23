import 'messages.dart';

/// The translations for Hungarian (`hu`).
class FormBuilderLocalizationsImplHu extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplHu([String locale = 'hu']) : super(locale);

  @override
  String get creditCardErrorText =>
      'A megadott érték nem egy érvényes bankkártya szám.';

  @override
  String get dateStringErrorText => 'Ennek a mezőnek dátumnak kell lennie.';

  @override
  String get emailErrorText => 'A megadott érték nem egy érvényes email cím.';

  @override
  String equalErrorText(Object value) {
    return 'Ennek a mezőértéknek meg kell egyeznie $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Az értéknek hosszúnak kell lennie $length';
  }

  @override
  String get integerErrorText => 'Ez a mező érvényes egész számot igényel.';

  @override
  String get ipErrorText => 'A megadott érték nem egy érvényes IP cím.';

  @override
  String get matchErrorText =>
      'A megadott érték nem egyezik a szükséges formátummal.';

  @override
  String maxErrorText(Object max) {
    return 'Az érték legyen legfeljebb $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Value must have a length less than or equal to $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Az értéknek olyan szavakkal kell rendelkeznie, amelyeknél kevesebb vagy egyenlő a $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Az érték legyen legalább $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Az értéknel legalább $minLength karakter hosszúnak kell lennie';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Az értéknek olyan szavakkal kell rendelkeznie, amelyeknél nagyobb vagy egyenlő a $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Ez a mezőérték nem lehet egyenlő $value.';
  }

  @override
  String get numericErrorText => 'Ebbe a mezőbe csak számot lehet írni.';

  @override
  String get requiredErrorText => 'Ennek a mezőnek értéket kell adni.';

  @override
  String get urlErrorText => 'A megadott érték nem egy érvényes URL cím.';
}

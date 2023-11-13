import 'messages.dart';

/// The translations for Hebrew (`he`).
class FormBuilderLocalizationsImplHe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplHe([String locale = 'he']) : super(locale);

  @override
  String get creditCardErrorText => 'שדה זה דורש מספר כרטיס אשראי תקין.';

  @override
  String get dateStringErrorText => 'שדה זה דורש מחרוזת תאריך תקינה.';

  @override
  String get emailErrorText => 'שדה זה דורש כתובת דוא\"ל תקינה.';

  @override
  String equalErrorText(Object value) {
    return 'ערך זה חייב להיות שווה ל $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'ערך זה חייב להיות באורך שווה ל $length';
  }

  @override
  String get integerErrorText => 'שדה זה דורש מספר שלם תקין.';

  @override
  String get ipErrorText => 'שדה זה דורש כתובת IP תקינה.';

  @override
  String get matchErrorText => 'ערך זה אינו תואם לתבנית.';

  @override
  String maxErrorText(Object max) {
    return 'ערך זה חייב להיות קטן או שווה ל $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'ערך זה חייב להיות באורך קטן או שווה ל $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'ערך זה חייב להיות באורך מילים קטן או שווה ל $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'ערך זה חייב להיות גדול או שווה ל $min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'ערך זה חייב להיות באורך גדול או שווה ל $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'ערך זה חייב להיות באורך מילים גדול או שווה ל $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'ערך זה חייב להיות שונה מ $value.';
  }

  @override
  String get numericErrorText => 'ערך זה חייב להיות מספרי.';

  @override
  String get requiredErrorText => 'שדה זה אינו יכול להיות ריק.';

  @override
  String get urlErrorText => 'שדה זה דורש כתובת URL תקינה.';
}

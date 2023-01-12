import 'messages.dart';

/// The translations for Modern Greek (`el`).
class FormBuilderLocalizationsImplEl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplEl([String locale = 'el']) : super(locale);

  @override
  String get requiredErrorText => 'Το πεδίο δεν μπορεί να είναι κενό.';

  @override
  String minErrorText(Object min) {
    return 'Η τιμή πρέπει να είναι μεγαλύτερη ή ίση με $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Η τιμή πρέπει να έχει μήκος μεγαλύτερο ή ίσο με $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Value must have a words count greater than or equal to $minWordsCount';
  }

  @override
  String maxErrorText(Object max) {
    return 'Η τιμή πρέπει να είναι μικρότερη ή ίση με $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Η τιμή πρέπει να έχει μήκος μικρότερο ή ίσο με $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Value must have a words count less than or equal to $maxWordsCount';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Η τιμή πρέπει να έχει μήκος ίσο με $length.';
  }

  @override
  String get emailErrorText => 'Το πεδίο πρέπει να έχει μία έγκυρη διεύθυνση email.';

  @override
  String get integerErrorText => 'Η τιμή πρέπει να είναι ακέραιος αριθμό.';

  @override
  String equalErrorText(Object value) {
    return 'Η τιμή πρέπει να είναι ίση με $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Η τιμή δεν πρέπει να είναι ίση με $value.';
  }

  @override
  String get urlErrorText => 'Η τιμή πρέπει να είναι έγκυρη διεύθυνση URL.';

  @override
  String get matchErrorText => 'Η τιμή δεν ταιριάζει με το μοτίβο.';

  @override
  String get numericErrorText => 'Η τιμή πρέπει να είναι αριθμητική.';

  @override
  String get creditCardErrorText => 'Η τιμή πρέπει να είναι έγκυρη πιστωτική κάρτα.';

  @override
  String get ipErrorText => 'Η τιμή πρέπει να είναι έγκυρη IP διεύθυνση.';

  @override
  String get dateStringErrorText => 'Η τιμή πρέπει να είναι έγκυρη ημερομηνία.';
}

import 'messages.dart';

/// The translations for Bengali Bangla (`bn`).
class FormBuilderLocalizationsImplBn extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplBn([String locale = 'bn']) : super(locale);

  @override
  String get requiredErrorText => 'খালি রাখা যাবে না।';

  @override
  String minErrorText(Object min) {
    return 'মান অবশ্যই $min এর থেকে বেশি বা সমান হতে হবে।';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'মান অবশ্যই $minLength এর চেয়ে বেশি বা সমান সংখ্যা হতে হবে।';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'মান অবশ্যই একটি শব্দের গণনা থাকতে হবে $minWordsCount এর চেয়ে বেশি বা সমান';
  }

  @override
  String maxErrorText(Object max) {
    return 'মান অবশ্যই $max এর কম বা সমান হতে হবে।';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'মান অবশ্যই $maxLength এর থেকে কম বা সমান সংখ্যা হতে হবে।';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'মান অবশ্যই একটি শব্দের গণনা থাকতে হবে $maxWordsCount এর চেয়ে কম বা সমান';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'একটি বৈধ ইমেল আইডি প্রয়োজন।';

  @override
  String get integerErrorText => 'মান অবশ্যই একটি পূর্ণসংখ্যা হতে হবে।';

  @override
  String equalErrorText(Object value) {
    return 'মান $value সমান হতে হবে।';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'মান $value এর সমান হওয়া উচিত নয়।';
  }

  @override
  String get urlErrorText => 'একটি বৈধ ওয়েব এড্রেস প্রয়োজন।';

  @override
  String get matchErrorText => 'মান প্যাটার্নের সাথে মেলে না।';

  @override
  String get numericErrorText => 'মান অবশ্যই সংখ্যায় হতে হবে।';

  @override
  String get creditCardErrorText => 'বৈধ ক্রেডিট কার্ড নম্বর প্রয়োজন।';

  @override
  String get ipErrorText => 'একটি বৈধ আইপি এড্রেস প্রয়োজন।';

  @override
  String get dateStringErrorText => 'একটি বৈধ তারিখ প্রয়োজন।';
}

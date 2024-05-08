import 'messages.dart';

/// The translations for Persian (`fa`).
class FormBuilderLocalizationsImplFa extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplFa([String locale = 'fa']) : super(locale);

  @override
  String get creditCardErrorText =>
      'این ورودی به شماره کارت اعتباری معتبر نیاز دارد.';

  @override
  String get dateStringErrorText => 'این ورودی به یک تاریخ معتبر نیاز دارد.';

  @override
  String get emailErrorText => 'این ورودی به یک آدرس ایمیل معتبر نیاز دارد.';

  @override
  String equalErrorText(Object value) {
    return 'مقدار این ورودی باید برابر با $value باشد.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'طول مقدار باید برابر باشد $length';
  }

  @override
  String get integerErrorText => 'این ورودی به یک عدد صحیح معتبر نیاز دارد.';

  @override
  String get ipErrorText => 'این قسمت نیاز به یک IP معتبر دارد.';

  @override
  String get matchErrorText => 'مقدار با الگو مطابقت ندارد.';

  @override
  String maxErrorText(Object max) {
    return 'مقدار باید برابر یا کمتر از $max باشد.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'مقدار باید دارای طول بزرگتر یا برابر $maxLength باشد.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'مقدار باید یک کلمات کمتر از یا مساوی با $maxWordsCount داشته باشد';
  }

  @override
  String minErrorText(Object min) {
    return 'مقدار باید برابر یا بیشتر از $min باشد.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'مقدار باید دارای طول بزرگتر یا برابر $minLength باشد.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'مقدار باید یک کلمات بیشتر از یا مساوی با $minWordsCount داشته باشد';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'مقدار این ورودی نباید برابر با $value باشد.';
  }

  @override
  String get numericErrorText => 'مقدار باید عددی باشد.';

  @override
  String get requiredErrorText => 'این ورودی نمی تواند خالی باشد.';

  @override
  String get urlErrorText => 'این ورودی به آدرس اینترنتی معتبر نیاز دارد.';
}

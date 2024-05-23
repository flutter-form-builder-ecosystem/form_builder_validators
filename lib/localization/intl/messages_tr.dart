import 'messages.dart';

/// The translations for Turkish (`tr`).
class FormBuilderLocalizationsImplTr extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplTr([String locale = 'tr']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Bu alan geçerli bir kredi kartı numarası gerektirir.';

  @override
  String get dateStringErrorText => 'Bu alan geçerli bir tarih gerektirir.';

  @override
  String get emailErrorText => 'Bu alan geçerli bir e-posta adresi gerektirir.';

  @override
  String equalErrorText(Object value) {
    return 'Bu alanın değeri, $value değerine eşit olmalıdır.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Değerin uzunluğu $length değerine eşit olmalıdır.';
  }

  @override
  String get integerErrorText => 'Bu alan geçerli bir tamsayı gerektirir.';

  @override
  String get ipErrorText => 'Bu alan geçerli bir IP adresi gerektirir.';

  @override
  String get matchErrorText => 'Lütfen geçerli bir değer giriniz.';

  @override
  String maxErrorText(Object max) {
    return 'Değer $max değerinden küçük veya eşit olmalıdır.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Değerin uzunluğu $maxLength değerinden küçük veya eşit olmalıdır.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Değer, $maxWordsCount \'dan daha az veya eşit bir kelimeye sahip olmalıdır';
  }

  @override
  String minErrorText(Object min) {
    return 'Değer $min değerinden büyük veya eşit olmalıdır.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Değerin uzunluğu $minLength değerinden büyük veya eşit olmalıdır.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Değer, $minWordsCount \'dan daha büyük veya eşit bir kelimeye sahip olmalıdır';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Bu alanın değeri, $value değerine eşit olmamalıdır.';
  }

  @override
  String get numericErrorText => 'Değer sayısal olmalıdır.';

  @override
  String get requiredErrorText => 'Bu alan boş olamaz.';

  @override
  String get urlErrorText => 'Bu alan geçerli bir URL adresi gerektirir.';
}

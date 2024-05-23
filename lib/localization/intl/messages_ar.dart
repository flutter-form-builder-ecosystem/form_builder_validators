import 'messages.dart';

/// The translations for Arabic (`ar`).
class FormBuilderLocalizationsImplAr extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplAr([String locale = 'ar']) : super(locale);

  @override
  String get creditCardErrorText =>
      'القيمة المدخلة لا تصلح كرقم بطاقة إئتمانية.';

  @override
  String get dateStringErrorText => 'هذا الحقل يتطلب تاريخا صالحا.';

  @override
  String get emailErrorText => 'هذا الحقل يتطلب عنوان بريد إلكتروني صالح.';

  @override
  String equalErrorText(Object value) {
    return 'يجب أن تكون القيمة المدخلة مساوية لـ $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'يجب أن يكون طول القيمة يساوي $length';
  }

  @override
  String get integerErrorText => 'القيمة المدخلة ليست رقما صحيحا.';

  @override
  String get ipErrorText => 'هذا الحقل يتطلب عنوان IP صالح.';

  @override
  String get matchErrorText => 'القيمة المدخلة لا تطابق الصيغة المطلوبة.';

  @override
  String maxErrorText(Object max) {
    return 'يجب أن لا تزيد القيمة المدخلة عن $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'يجب أن لا يزيد طول القيمة المدخلة عن $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'يجب أن لا يزيد عدد الكلمات المدخلة عن $maxWordsCount.';
  }

  @override
  String minErrorText(Object min) {
    return 'يجب أن لا تقل القيمة المدخلة عن $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'يجب أن لا يقل طول القيمة المدخلة عن $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'يجب أن لا يقل عدد الكلمات المدخلة عن $minWordsCount.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'يجب أن لا تكون القيمة المدخلة مساوية لـ $value.';
  }

  @override
  String get numericErrorText => 'القيمة المدخلة ليست رقما.';

  @override
  String get requiredErrorText => 'هذا الحقل يجب ملؤه.';

  @override
  String get urlErrorText => 'هذا الحقل يتطلب عنوان URL صالح.';
}

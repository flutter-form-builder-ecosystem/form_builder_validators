import 'messages.dart';

/// The translations for Vietnamese (`vi`).
class FormBuilderLocalizationsImplVi extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplVi([String locale = 'vi']) : super(locale);

  @override
  String get creditCardErrorText => 'Yêu cầu nhập đúng số thẻ tín dụng.';

  @override
  String get dateStringErrorText => 'Yêu cầu nhập đúng định dạng ngày.';

  @override
  String get emailErrorText => 'Nhập đúng email.';

  @override
  String equalErrorText(Object value) {
    return 'Bắt buộc bằng $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Độ dài phải bằng $length';
  }

  @override
  String get integerErrorText => 'Yêu cầu nhập một số nguyên.';

  @override
  String get ipErrorText => 'Yêu cầu nhập đúng địa chỉ IP.';

  @override
  String get matchErrorText => 'Giá trị không khớp.';

  @override
  String maxErrorText(Object max) {
    return 'Giá trị phải nhỏ hơn hoặc bằng $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Độ dài phải nhỏ hơn hoặc bằng $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Giá trị phải có số từ nhỏ hơn hoặc bằng $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Giá trị phải lớn hơn hoặc bằng $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Độ dài phải lớn hơn hoặc bằng $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Giá trị phải có số từ lớn hơn hoặc bằng $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Bắt buộc khác $value.';
  }

  @override
  String get numericErrorText => 'Yêu cầu nhập một số.';

  @override
  String get requiredErrorText => 'Không được bỏ trống.';

  @override
  String get urlErrorText => 'Nhập đúng địa chỉ URL.';
}

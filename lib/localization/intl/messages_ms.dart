import 'messages.dart';

/// The translations for Malay (`ms`).
class FormBuilderLocalizationsImplMs extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplMs([String locale = 'ms']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Ruangan ini memerlukan nombor kad kredit yang sah.';

  @override
  String get dateStringErrorText =>
      'Ruangan ini memerlukan rentetan tarikh yang sah.';

  @override
  String get emailErrorText => 'Ruang ini memerlukan alamat e-mel yang sah.';

  @override
  String equalErrorText(Object value) {
    return 'Nilai Ruangan ini wajib sama dengan $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Nilai mesti mempunyai panjang yang sama dengan $length';
  }

  @override
  String get integerErrorText => 'Ruang ini memerlukan integer yang sah.';

  @override
  String get ipErrorText => 'Ruangan ini memerlukan IP yang sah.';

  @override
  String get matchErrorText => 'Nilai tidak sepadan dengan corak.';

  @override
  String maxErrorText(Object max) {
    return 'Nilai wajib kurang daripada atau sama dengan $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Nilai mesti mempunyai panjang kurang daripada atau sama dengan $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Nilai mesti mempunyai kata -kata yang kurang daripada atau sama dengan $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Nilai wajib lebih besar daripada atau sama dengan $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Nilai mesti mempunyai panjang lebih besar daripada atau sama dengan $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Nilai mesti mempunyai kata -kata yang lebih besar daripada atau sama dengan $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Nilai ruangan ini wajib tidak sama dengan $value.';
  }

  @override
  String get numericErrorText => 'Nilai wajib dalam bentuk angka.';

  @override
  String get requiredErrorText => 'Ruang ini wajib diisi.';

  @override
  String get urlErrorText => 'Ruangan ini memerlukan alamat URL yang sah.';
}

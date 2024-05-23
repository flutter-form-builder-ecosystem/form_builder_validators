import 'messages.dart';

/// The translations for Indonesian (`id`).
class FormBuilderLocalizationsImplId extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplId([String locale = 'id']) : super(locale);

  @override
  String get creditCardErrorText => 'Nomor kartu kredit tidak valid.';

  @override
  String get dateStringErrorText => 'Tanggal tidak valid';

  @override
  String get emailErrorText => 'Alamat email tidak valid.';

  @override
  String equalErrorText(Object value) {
    return 'Nilai bidang ini harus sama dengan $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Nilai harus memiliki panjang yang sama dengan $length';
  }

  @override
  String get integerErrorText => 'Nilai harus berupa bilangan bulat.';

  @override
  String get ipErrorText => 'Alamat IP tidak valid.';

  @override
  String get matchErrorText => 'Nilai tidak cocok dengan pola.';

  @override
  String maxErrorText(Object max) {
    return 'Nilai harus kurang dari atau sama dengan $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Panjang karakter harus kurang dari atau sama dengan $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Nilai harus memiliki jumlah kata kurang dari atau sama dengan $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Nilai harus lebih besar dari atau sama dengan $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Panjang karakter harus lebih besar dari atau sama dengan $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Nilai harus memiliki kata yang diperhitungkan lebih besar dari atau sama dengan $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Nilai bidang ini tidak boleh sama dengan $value.';
  }

  @override
  String get numericErrorText => 'Nilai harus berupa angka.';

  @override
  String get requiredErrorText => 'Bidang ini tidak boleh kosong.';

  @override
  String get urlErrorText => 'URL tidak valid';
}

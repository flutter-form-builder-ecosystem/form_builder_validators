import 'messages.dart';

/// The translations for Lao (`lo`).
class FormBuilderLocalizationsImplLo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplLo([String locale = 'lo']) : super(locale);

  @override
  String get creditCardErrorText =>
      'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງເລກບັດເຄຣດິດ.';

  @override
  String get dateStringErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງວັນທີ.';

  @override
  String get emailErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງ ອີເມວ໌.';

  @override
  String equalErrorText(Object value) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງເທົ່າກັບ $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'ມູນຄ່າຕ້ອງມີຄວາມຍາວເທົ່າກັບ $length';
  }

  @override
  String get integerErrorText => 'ຄ່າທີ່ປ້ອນໃສ່ຕ້ອງເປັນໂຕເລກຖ້ວນເທົ່ານັ້ນ.';

  @override
  String get ipErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງເລກ IP.';

  @override
  String get matchErrorText => 'ຄ່າບໍ່ຖືກຕ້ອງຕາມຮູບແບບທີ່ກຳນົດ.';

  @override
  String maxErrorText(Object max) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງນ້ອຍກວ່າ ຫຼືເທົ່າກັບ $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງມີຄວາມຍາວໜ້ອຍກວ່າ ຫຼືເທົ່າກັບ $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'ມູນຄ່າຕ້ອງມີຄໍາສັບຫນ້ອຍກວ່າຫຼືເທົ່າກັບ $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງໃຫຍ່ກວ່າ ຫຼືເທົ່າກັບ $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງມີຄວາມຍາວຫຼາຍກວ່າ ຫຼືເທົ່າກັບ $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'ມູນຄ່າຕ້ອງມີຄໍາສັບທີ່ໃຫຍ່ກວ່າຫຼືເທົ່າກັບ $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງບໍ່ເທົ່າກັບ $value.';
  }

  @override
  String get numericErrorText => 'ຄ່າທີ່ປ້ອນໃສ່ຕ້ອງເປັນໂຕເລກເທົ່ານັ້ນ.';

  @override
  String get requiredErrorText => 'ແບບຟອມນີ້ບໍ່ສາມາດຫວ່າງເປົ່າໄດ້.';

  @override
  String get urlErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງ URL.';
}

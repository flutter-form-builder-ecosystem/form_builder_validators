import 'messages.dart';

/// The translations for Lao (`lo`).
class FormBuilderLocalizationsImplLo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplLo([String locale = 'lo']) : super(locale);

  @override
  String get requiredErrorText => 'ແບບຟອມນີ້ບໍ່ສາມາດຫວ່າງເປົ່າໄດ້.';

  @override
  String minErrorText(Object min) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງໃຫຍ່ກວ່າ ຫຼືເທົ່າກັບ $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງມີຄວາມຍາວຫຼາຍກວ່າ ຫຼືເທົ່າກັບ $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງນ້ອຍກວ່າ ຫຼືເທົ່າກັບ $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງມີຄວາມຍາວໜ້ອຍກວ່າ ຫຼືເທົ່າກັບ $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງ ອີເມວ໌.';

  @override
  String get integerErrorText => 'ຄ່າທີ່ປ້ອນໃສ່ຕ້ອງເປັນໂຕເລກຖ້ວນເທົ່ານັ້ນ.';

  @override
  String equalErrorText(Object value) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງເທົ່າກັບ $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'ຄ່າໃນຟອມນີ້ຕ້ອງບໍ່ເທົ່າກັບ $value.';
  }

  @override
  String get urlErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງ URL.';

  @override
  String get matchErrorText => 'ຄ່າບໍ່ຖືກຕ້ອງຕາມຮູບແບບທີ່ກຳນົດ.';

  @override
  String get numericErrorText => 'ຄ່າທີ່ປ້ອນໃສ່ຕ້ອງເປັນໂຕເລກເທົ່ານັ້ນ.';

  @override
  String get creditCardErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງເລກບັດເຄຣດິດ.';

  @override
  String get ipErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງເລກ IP.';

  @override
  String get dateStringErrorText => 'ຄ່າໃນຟອມນີ້ຕ້ອງຢູ່ໃນຮູບແບບຂອງວັນທີ.';
}

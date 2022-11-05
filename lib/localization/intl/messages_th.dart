import 'messages.dart';

/// The translations for Thai (`th`).
class FormBuilderLocalizationsImplTh extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplTh([String locale = 'th']) : super(locale);

  @override
  String get requiredErrorText => 'กรุณาระบุข้อมูล';

  @override
  String minErrorText(Object min) {
    return 'ข้อมูลนี้ต้องมีค่ามากกว่าหรือเท่ากับ $min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'ความยาวตัวอักษาต้องมีจำนวนมากกว่าหรือเท่ากับ $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'ข้อมูลนี้ต้องมีค่าน้อยกว่าหรือเท่ากับ $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'ความยาวตัวอักษาต้องมีจำนวนน้อยกว่าหรือเท่ากับ $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'ความยาวตัวอักษาต้องมีจำนวนเท่ากับ $length';
  }

  @override
  String get emailErrorText => 'กรุณาระบุ email ของคุณ';

  @override
  String get integerErrorText => 'ข้อมูลนี้ต้องเป็นตัวเลขเท่านั้น';

  @override
  String equalErrorText(Object value) {
    return 'ข้อมูลนี้ต้องเท่ากับ $value เท่านั้น';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'ข้อมูลนี้ต้องไม่เท่ากับ $value';
  }

  @override
  String get urlErrorText => 'ข้อมูลนี้ต้องเป็น URL address เท่านั้น';

  @override
  String get matchErrorText => 'ข้อมูลนี้ไม่ตรงกับรูปแบบที่ระบุไว้';

  @override
  String get numericErrorText => 'ข้อมูลนี้ต้องเป็นตัวเลขเท่านั้น';

  @override
  String get creditCardErrorText => 'ข้อมูลนี้ต้องเป็นเลขบัตรเครดิตเท่านั้น';

  @override
  String get ipErrorText => 'ข้อมูลนี้ต้องเป็น IP เท่านั้น';

  @override
  String get dateStringErrorText => 'ข้อมูลนี้ต้องเป็นวันที่เท่านั้น';
}

import 'messages.dart';

/// The translations for English (`en`).
class FormBuilderLocalizationsImplEn extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplEn([String locale = 'en']) : super(locale);

  @override
  String get requiredErrorText => 'Заавал бөглөнө үү.';

  @override
  String minErrorText(Object min) {
    return '$min-аас их утга оруулна уу.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return '$minLength-аас урт утга оруулна уу.';
  }

  @override
  String maxErrorText(Object max) {
    return '$max-аас бага утга оруулна уу.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '$maxLength-аас богино утга оруулна уу.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return '$length урттай утга оруулна уу.';
  }

  @override
  String get emailErrorText => 'И-мэйл хаяг оруулна уу.';

  @override
  String get integerErrorText => 'Бүхэл тоон утга оруулна уу.';

  @override
  String equalErrorText(Object value) {
    return '$value-тэй тэнцүү утга оруулна уу.';
  }

  @override
  String notEqualErrorText(Object value) {
    return '$value-тай тэнцүү биш утга оруулна уу.';
  }

  @override
  String get urlErrorText => 'URL хаяг оруулна уу.';

  @override
  String get matchErrorText => 'Загвартай таарахгүй байна.';

  @override
  String get numericErrorText => 'Тоон утга оруулна уу.';

  @override
  String get creditCardErrorText => 'Кредит картын биш байна.';

  @override
  String get ipErrorText => 'IP хаяг биш байна.';

  @override
  String get dateStringErrorText => 'Огнооны загварт таарахгүй байна.';
}

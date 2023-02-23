import 'messages.dart';

/// The translations for Mongolian (`mn`).
class FormBuilderLocalizationsImplMn extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplMn([String locale = 'mn']) : super(locale);

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
    return '$max-аас их утга оруулна уу.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '$maxLength-аас богино утга оруулна уу.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return '$length-тэй тэнцүү урттай утга оруулна уу.';
  }

  @override
  String get emailErrorText => 'И-мэйл хаяг алдаатай байна.';

  @override
  String get integerErrorText => 'Бүхэл тоон утга оруулна уу.';

  @override
  String equalErrorText(Object value) {
    return '$value-тэй тэнцүү утга оруулна уу.';
  }

  @override
  String notEqualErrorText(Object value) {
    return '$value-тэй тэнцүү биш утга оруулна уу.';
  }

  @override
  String get urlErrorText => 'URL хаяг алдаатай байна.';

  @override
  String get matchErrorText => 'Утга загварт таарахгүй байна.';

  @override
  String get numericErrorText => 'Тоон утга оруулна уу.';

  @override
  String get creditCardErrorText => 'Картын дугаар алдаатай байна.';

  @override
  String get ipErrorText => 'IP хаяг алдаатай байна.';

  @override
  String get dateStringErrorText => 'Огнооны загварт таарахгүй байна.';

  @override
  String maxWordsCountErrorText(Object value) {
    return 'Утга нь түүнээс бага буюу тэнцүү тоолох үгстэй байх ёстой $value.';
  }

  @override
  String minWordsCountErrorText(Object value) {
    return 'Утга нь түүнээс их буюу тэнцүү тооны үгтэй байх ёстой $value.';
  }
}

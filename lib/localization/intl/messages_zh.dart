import 'messages.dart';

/// The translations for Chinese (`zh`).
class FormBuilderLocalizationsImplZh extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplZh([String locale = 'zh']) : super(locale);

  @override
  String get creditCardErrorText => '该字段必须是有效的信用卡号';

  @override
  String get dateStringErrorText => '该字段必须是有效的时间日期';

  @override
  String get emailErrorText => '该字段必须是有效的电子邮件地址';

  @override
  String equalErrorText(Object value) {
    return '该字段必须等于$value';
  }

  @override
  String equalLengthErrorText(Object length) {
    return '该字段的长度必须等于$length';
  }

  @override
  String get integerErrorText => '该字段必须是整数';

  @override
  String get ipErrorText => '该字段必须是有效的IP';

  @override
  String get matchErrorText => '该字段格式不正确';

  @override
  String maxErrorText(Object max) {
    return '该字段必须小于等于$max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '该字段的长度必须小于等于$maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return '值必须具有小于或等于$maxWordsCount的单词计数';
  }

  @override
  String minErrorText(Object min) {
    return '该字段必须大于等于$min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return '该字段的长度必须大于等于$minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return '值必须具有大于或等于$minWordsCount的单词计数';
  }

  @override
  String notEqualErrorText(Object value) {
    return '该字段不能等于$value';
  }

  @override
  String get numericErrorText => '该字段必须是数字';

  @override
  String get requiredErrorText => '该字段不能为空。';

  @override
  String get urlErrorText => '该字段必须是有效的URL地址';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class FormBuilderLocalizationsImplZhHant
    extends FormBuilderLocalizationsImplZh {
  FormBuilderLocalizationsImplZhHant() : super('zh_Hant');

  @override
  String get creditCardErrorText => '此欄位需要有效的信用卡號碼。';

  @override
  String get dateStringErrorText => '此欄位需要有效的日期字符串。';

  @override
  String get emailErrorText => '此欄位需要有效的電子郵件地址。';

  @override
  String equalErrorText(Object value) {
    return '此欄位必須與$value相符';
  }

  @override
  String equalLengthErrorText(Object length) {
    return '值必須具有等於$length的長度';
  }

  @override
  String get integerErrorText => '此欄位需要有效的整數。';

  @override
  String get ipErrorText => '此欄位需要有效的IP。';

  @override
  String get matchErrorText => '此欄位與格式不匹配。';

  @override
  String maxErrorText(Object max) {
    return '此欄位必須小於或等於$max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '此欄位的長度必須小於或等於$maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return '值必須具有小於或等於$maxWordsCount的單詞計數';
  }

  @override
  String minErrorText(Object min) {
    return '此欄位必須大於或等於$min';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return '此欄位的長度必須大於或等於$minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return '值必須具有大於或等於$minWordsCount的單詞計數';
  }

  @override
  String notEqualErrorText(Object value) {
    return '此欄位不得等於$value';
  }

  @override
  String get numericErrorText => '此欄位必須是數字。';

  @override
  String get requiredErrorText => '此欄位不能為空。';

  @override
  String get urlErrorText => '此欄位需要有效的URL地址。';
}

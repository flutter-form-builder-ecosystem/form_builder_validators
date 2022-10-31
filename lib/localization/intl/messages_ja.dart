import 'messages.dart';

/// The translations for Japanese (`ja`).
class FormBuilderLocalizationsImplJa extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplJa([String locale = 'ja']) : super(locale);

  @override
  String get requiredErrorText => '必須項目です。';

  @override
  String minErrorText(Object min) {
    return '$min以上にしてください。';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return '$minLength文字以上で入力してください。';
  }

  @override
  String maxErrorText(Object max) {
    return '$max以下にしてください。';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '$maxLength文字以下で入力してください。';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => '有効なメールアドレスを入力してください。';

  @override
  String get integerErrorText => '整数で入力してください。';

  @override
  String equalErrorText(Object value) {
    return '$valueに一致していません。';
  }

  @override
  String notEqualErrorText(Object value) {
    return '$valueと違うものにしてください。';
  }

  @override
  String get urlErrorText => '有効なURLを入力してください。';

  @override
  String get matchErrorText => '有効な正規表現を指定してください。';

  @override
  String get numericErrorText => '半角数字で入力してください。';

  @override
  String get creditCardErrorText => '有効なクレジットカード番号を入力してください。';

  @override
  String get ipErrorText => '有効なIPアドレスを入力してください。';

  @override
  String get dateStringErrorText => '正しい日付を入力してください。';
}

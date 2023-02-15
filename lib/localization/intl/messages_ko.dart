import 'messages.dart';

/// The translations for Korean (`ko`).
class FormBuilderLocalizationsImplKo extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplKo([String locale = 'ko']) : super(locale);

  @override
  String get requiredErrorText => '이 필드는 반드시 입력해야 합니다.';

  @override
  String minErrorText(Object min) {
    return '이 필드의 값은 반드시 $min 이상이어야 합니다.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return '이 필드는 반드시 $minLength자 이상이어야 합니다.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return '값은 $minWordsCount보다 큰 단어 수를 가져야합니다.';
  }

  @override
  String maxErrorText(Object max) {
    return '이 필드의 값은 반드시 $max 이하이어야 합니다.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return '이 필드는 반드시 $maxLength자 이하이어야 합니다.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return '값은 $maxWordsCount보다 작거나 같은 단어를 가져야합니다.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => '이메일 주소 형식이 올바르지 않습니다.';

  @override
  String get integerErrorText => '정수만 입력 가능합니다.';

  @override
  String equalErrorText(Object value) {
    return '이 필드의 값은 반드시 $value와 같아야 합니다.';
  }

  @override
  String notEqualErrorText(Object value) {
    return '이 필드의 값은 반드시 $value와 달라야 합니다.';
  }

  @override
  String get urlErrorText => 'URL 형식이 올바르지 않습니다.';

  @override
  String get matchErrorText => '필드의 값이 패턴과 맞지 않습니다.';

  @override
  String get numericErrorText => '숫자만 입력 가능합니다.';

  @override
  String get creditCardErrorText => '유효한 카드 번호를 입력해 주세요.';

  @override
  String get ipErrorText => '유효한 IP를 입력해 주세요.';

  @override
  String get dateStringErrorText => '날짜 형식이 올바르지 않습니다.';
}

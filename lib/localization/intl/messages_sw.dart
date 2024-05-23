import 'messages.dart';

/// The translations for Swahili (`sw`).
class FormBuilderLocalizationsImplSw extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplSw([String locale = 'sw']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Sehemu hii inahitaji nambari halali ya kadi ya mkopo.';

  @override
  String get dateStringErrorText =>
      'Sehemu hii inahitaji mfuatano halali wa tarehe.';

  @override
  String get emailErrorText => 'Sehemu hii inahitaji barua pepe halali.';

  @override
  String equalErrorText(Object value) {
    return 'Thamani ya sehemu hii lazima iwe sawa na $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Thamani lazima iwe na urefu sawa na $length';
  }

  @override
  String get integerErrorText => 'Sehemu hii inahitaji nambari kamili halali.';

  @override
  String get ipErrorText => 'Sehemu hii inahitaji IP halali.';

  @override
  String get matchErrorText => 'Thamani hailingani na muundo.';

  @override
  String maxErrorText(Object max) {
    return 'Thamani lazima iwe chini ya au sawa na $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Thamani lazima iwe na urefu chini ya au sawa na $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Thamani lazima iwe na hesabu ya maneno chini ya au sawa na $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Thamani lazima iwe kubwa kuliko au sawa na $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Thamani lazima iwe na urefu mkubwa kuliko au sawa na $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Thamani lazima iwe na maneno kuhesabu kubwa kuliko au sawa na $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Thamani hii ya sehemu haifai kuwa sawa na $value.';
  }

  @override
  String get numericErrorText => 'Thamani lazima iwe nambari.';

  @override
  String get requiredErrorText => 'Sehemu hii haiwezi kuwa tupu.';

  @override
  String get urlErrorText => 'Sehemu hii inahitaji anwani sahihi ya tovuti.';
}

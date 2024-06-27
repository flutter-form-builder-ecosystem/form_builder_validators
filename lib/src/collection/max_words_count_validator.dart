import '../../localization/l10n.dart';
import '../base_validator.dart';

class MaxWordsCountValidator extends BaseValidator<String> {
  const MaxWordsCountValidator(
    this.maxWordsCount, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int maxWordsCount;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxWordsCountErrorText(maxWordsCount);

  @override
  String? validateValue(String valueCandidate) {
    final int wordsCount = valueCandidate.trim().split(' ').length;

    return wordsCount > maxWordsCount ? errorText : null;
  }
}

import '../../localization/l10n.dart';
import '../base_validator.dart';

class MinWordsCountValidator extends BaseValidator<String> {
  const MinWordsCountValidator(
    this.minWordsCount, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int minWordsCount;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minWordsCountErrorText(minWordsCount);

  @override
  String? validateValue(String? valueCandidate) {
    final int wordsCount = valueCandidate?.trim().split(' ').length ?? 0;

    return wordsCount < minWordsCount ? errorText : null;
  }
}

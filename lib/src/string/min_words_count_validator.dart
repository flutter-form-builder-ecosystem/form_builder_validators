import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template min_words_count_validator_template}
/// [MinWordsCountValidator] extends [BaseValidator] to validate if a string contains at least a specified number of words.
///
/// This validator checks if the number of words in the value is at least the specified minimum word count.
///
/// ## Parameters:
///
/// - [minWordsCount] The minimum required number of words.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MinWordsCountValidator extends BaseValidator<String> {
  /// Constructor for the minimum words count validator.
  const MinWordsCountValidator(
    this.minWordsCount, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum required number of words.
  final int minWordsCount;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minWordsCountErrorText(minWordsCount);

  @override
  String? validateValue(String valueCandidate) {
    final int wordsCount = valueCandidate.trim().split(RegExp(r'\s+')).length;

    return wordsCount < minWordsCount ? errorText : null;
  }
}

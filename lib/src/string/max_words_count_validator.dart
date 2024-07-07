import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template max_words_count_validator_template}
/// [MaxWordsCountValidator] extends [BaseValidator] to validate if a string contains no more than a specified number of words.
///
/// This validator checks if the number of words in the value does not exceed the specified maximum word count.
///
/// ## Parameters:
///
/// - [maxWordsCount] The maximum allowable number of words.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MaxWordsCountValidator extends BaseValidator<String> {
  /// Constructor for the maximum words count validator.
  const MaxWordsCountValidator(
    this.maxWordsCount, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The maximum allowable number of words.
  final int maxWordsCount;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxWordsCountErrorText(maxWordsCount);

  @override
  String? validateValue(String valueCandidate) {
    final int wordsCount = valueCandidate.trim().split(RegExp(r'\s+')).length;

    return wordsCount > maxWordsCount ? errorText : null;
  }
}

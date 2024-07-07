import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template contains_validator_template}
/// [ContainsValidator] extends [BaseValidator] to validate if a string contains a specified substring.
///
/// This validator checks if the value contains the specified substring, with an option for case sensitivity.
///
/// ## Parameters:
///
/// - [substring] The substring that the value must contain.
/// - [caseSensitive] Whether the search should be case-sensitive. Defaults to true.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class ContainsValidator extends BaseValidator<String> {
  /// Constructor for the contains validator.
  const ContainsValidator(
    this.substring, {
    this.caseSensitive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The substring that the value must contain.
  final String substring;

  /// Whether the search should be case-sensitive.
  final bool caseSensitive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsErrorText(substring);

  @override
  String? validateValue(String valueCandidate) {
    if (substring.isEmpty) {
      return errorText;
    } else if (caseSensitive
        ? valueCandidate.contains(substring)
        : valueCandidate.toLowerCase().contains(substring.toLowerCase())) {
      return null;
    }
    return errorText;
  }
}

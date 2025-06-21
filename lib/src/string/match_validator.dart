import '../../form_builder_validators.dart';

/// {@template match_validator_template}
/// [MatchValidator] extends [TranslatedValidator] to validate if a string matches a specified regular expression pattern.
///
/// This validator checks if the value matches the provided regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression pattern that the value must match.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MatchValidator extends TranslatedValidator<String> {
  /// Constructor for the match validator.
  const MatchValidator(
    this.regex, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The regular expression pattern that the value must match.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.matchErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return regex.hasMatch(valueCandidate) ? null : errorText;
  }
}

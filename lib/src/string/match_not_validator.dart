import '../../form_builder_validators.dart';

/// {@template match_not_validator_template}
/// [MatchNotValidator] extends [TranslatedValidator] to validate if a string does not match a specified regular expression pattern.
///
/// This validator checks if the value does not match the provided regex pattern.
///
/// ## Parameters:
///
/// - [regex] The regular expression pattern that the value must not match.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MatchNotValidator extends TranslatedValidator<String> {
  /// Constructor for the match not validator.
  const MatchNotValidator(
    this.regex, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The regular expression pattern that the value must not match.
  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.matchErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return !regex.hasMatch(valueCandidate) ? errorText : null;
  }
}

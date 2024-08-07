import '../../form_builder_validators.dart';

/// {@template uppercase_validator_template}
/// [UppercaseValidator] extends [TranslatedValidator] to validate if a string is entirely uppercase.
///
/// This validator checks if the value is the same as its uppercase version.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class UppercaseValidator extends TranslatedValidator<String> {
  /// Constructor for the uppercase validator.
  const UppercaseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.uppercaseErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.toUpperCase() == valueCandidate ? null : errorText;
  }
}

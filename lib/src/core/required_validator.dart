import '../../form_builder_validators.dart';

/// {@template required_validator_template}
/// [RequiredValidator] extends [TranslatedValidator] to validate that a value is required (non-null).
///
/// This validator is primarily used to ensure that a field is not left empty or null.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class RequiredValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the required value validator.
  const RequiredValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T valueCandidate) {
    // BaseValidator<T> will already check for null values
    return null;
  }
}

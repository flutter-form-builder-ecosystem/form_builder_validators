import '../../form_builder_validators.dart';

/// {@template is_false_validator_template}
/// [IsFalseValidator] extends [TranslatedValidator] to validate if a boolean value is false.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IsFalseValidator extends TranslatedValidator<bool> {
  /// Constructor for the false value validator.
  const IsFalseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeFalseErrorText;

  @override
  String? validateValue(bool valueCandidate) {
    return valueCandidate == false ? null : errorText;
  }
}

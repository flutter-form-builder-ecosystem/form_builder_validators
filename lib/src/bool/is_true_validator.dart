import '../../form_builder_validators.dart';
import '../elementary_validators/bool/bool.dart';

/// {@template is_true_validator_template}
/// [IsTrueValidator] extends [TranslatedValidator] to validate if a boolean value is true.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IsTrueValidator extends TranslatedValidator<bool> {
  /// Constructor for the true value validator.
  const IsTrueValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeTrueErrorText;

  @override
  String? validateValue(bool valueCandidate) {
    final IsTrueElementaryValidator elementaryValidator =
        IsTrueElementaryValidator(errorText: errorText);
    return elementaryValidator.transformValueIfValid(valueCandidate).$1
        ? null
        : elementaryValidator.errorText;
  }
}

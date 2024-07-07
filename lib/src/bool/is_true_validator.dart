import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template is_true_validator_template}
/// [IsTrueValidator] extends [BaseValidator] to validate if a boolean value is true.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class IsTrueValidator extends BaseValidator<bool> {
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
    return valueCandidate == true ? null : errorText;
  }
}

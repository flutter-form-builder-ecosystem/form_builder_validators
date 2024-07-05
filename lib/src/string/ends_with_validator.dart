import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template ends_with_validator_template}
/// [EndsWithValidator] extends [BaseValidator] to validate if a string ends with a specified suffix.
///
/// This validator checks if the value ends with the specified suffix.
///
/// ## Parameters:
///
/// - [suffix] The suffix that the value must end with.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class EndsWithValidator extends BaseValidator<String> {
  /// Constructor for the ends with validator.
  const EndsWithValidator(
    this.suffix, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The suffix that the value must end with.
  final String suffix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.endsWithErrorText(suffix);

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.endsWith(suffix) ? null : errorText;
  }
}

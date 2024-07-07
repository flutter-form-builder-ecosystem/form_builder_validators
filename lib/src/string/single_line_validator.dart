import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template single_line_validator_template}
/// [SingleLineValidator] extends [BaseValidator] to validate if a string contains only a single line.
///
/// This validator checks if the value does not contain any newline characters.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class SingleLineValidator extends BaseValidator<String> {
  /// Constructor for the single line validator.
  const SingleLineValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.singleLineErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.contains('\n') || valueCandidate.contains('\r')
        ? errorText
        : null;
  }
}

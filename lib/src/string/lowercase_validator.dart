import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template lowercase_validator_template}
/// [LowercaseValidator] extends [BaseValidator] to validate if a string is entirely lowercase.
///
/// This validator checks if the value is the same as its lowercase version.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class LowercaseValidator extends BaseValidator<String> {
  /// Constructor for the lowercase validator.
  const LowercaseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.lowercaseErrorText;

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.toLowerCase() == valueCandidate ? null : errorText;
  }
}

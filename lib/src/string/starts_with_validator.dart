import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template starts_with_validator_template}
/// [StartsWithValidator] extends [BaseValidator] to validate if a string starts with a specified prefix.
///
/// This validator checks if the value starts with the specified prefix.
///
/// ## Parameters:
///
/// - [prefix] The prefix that the value must start with.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class StartsWithValidator extends BaseValidator<String> {
  /// Constructor for the starts with validator.
  const StartsWithValidator(
    this.prefix, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The prefix that the value must start with.
  final String prefix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.startsWithErrorText(prefix);

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.startsWith(prefix) ? null : errorText;
  }
}

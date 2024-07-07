import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template odd_number_validator_template}
/// [OddNumberValidator] extends [BaseValidator] to validate if a string represents an odd number.
///
/// This validator checks if the provided string can be parsed into an integer and if that integer is odd.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class OddNumberValidator extends BaseValidator<String> {
  /// Constructor for the odd number validator.
  const OddNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.oddNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate);
    if (number == null || number.isEven) {
      return errorText;
    }
    return null;
  }
}

import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template even_number_validator_template}
/// [EvenNumberValidator] extends [BaseValidator] to validate if a string represents an even number.
///
/// This validator checks if the provided string can be parsed into an integer and if that integer is even.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class EvenNumberValidator extends BaseValidator<String> {
  /// Constructor for the even number validator.
  const EvenNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.evenNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate);
    if (number == null || number.isOdd) {
      return errorText;
    }
    return null;
  }
}

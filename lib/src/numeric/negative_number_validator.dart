import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template negative_number_validator_template}
/// [NegativeNumberValidator] extends [BaseValidator] to validate if a value is a negative number.
///
/// This validator checks if the value is a number or a string that can be parsed into a number and ensures it is negative.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class NegativeNumberValidator<T> extends BaseValidator<T> {
  /// Constructor for the negative number validator.
  const NegativeNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.negativeNumberErrorText;

  @override
  String? validateValue(T valueCandidate) {
    final num? value;
    if (valueCandidate is String) {
      value = num.tryParse(valueCandidate);
    } else if (valueCandidate is num) {
      value = valueCandidate;
    } else {
      return errorText;
    }

    if (value == null) {
      return errorText;
    }

    if (value >= 0) {
      return errorText;
    }

    return null;
  }
}

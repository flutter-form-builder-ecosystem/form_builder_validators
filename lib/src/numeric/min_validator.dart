import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template min_validator_template}
/// [MinValidator] extends [BaseValidator] to validate if a value is greater than or equal to a specified minimum value.
///
/// This validator checks if the value is a number or a string that can be parsed into a number and ensures it meets the specified minimum value.
///
/// ## Parameters:
///
/// - [min] The minimum allowable value.
/// - [inclusive] Whether the minimum value is inclusive. Defaults to true.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MinValidator<T> extends BaseValidator<T> {
  /// Constructor for the minimum value validator.
  const MinValidator(
    this.min, {
    this.inclusive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum allowable value.
  final num min;

  /// Whether the minimum value is inclusive.
  final bool inclusive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minErrorText(min);

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

    if (inclusive) {
      if (value < min) {
        return errorText;
      }
    } else {
      if (value <= min) {
        return errorText;
      }
    }

    return null;
  }
}

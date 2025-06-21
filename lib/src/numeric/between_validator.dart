import '../../form_builder_validators.dart';

/// {@template between_validator_template}
/// [BetweenValidator] extends [TranslatedValidator] to validate if a number is within a specified range.
///
/// This validator checks if the value is between the minimum and maximum inclusive.
///
/// ## Parameters:
///
/// - [min] The minimum allowable value.
/// - [max] The maximum allowable value.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class BetweenValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the between validator.
  const BetweenValidator(
    this.min,
    this.max, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum allowable value.
  final num min;

  /// The maximum allowable value.
  final num max;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.betweenErrorText(min, max);

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

    if (value == null || (value < min || value > max)) {
      return errorText;
    }

    return null;
  }
}

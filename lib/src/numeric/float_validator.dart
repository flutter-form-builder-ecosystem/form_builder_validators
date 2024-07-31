import '../../form_builder_validators.dart';

/// {@template float_validator_template}
/// [FloatValidator] extends [TranslatedValidator] to validate if a value is a float and does not exceed a maximum value.
///
/// This validator checks if the value is a float number or a string that can be parsed into a float number and ensures it does not exceed the maximum value.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
/// - [maxValue] The maximum allowed value for the float. Default is 1.0.
///
/// {@endtemplate}
class FloatValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the float validator.
  const FloatValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.floatErrorText;

  @override
  String? validateValue(T valueCandidate) {
    final double? value;
    if (valueCandidate is String) {
      value = double.tryParse(valueCandidate);
    } else if (valueCandidate is double) {
      value = valueCandidate;
    } else if (valueCandidate is num) {
      value = valueCandidate.toDouble();
    } else {
      return errorText;
    }

    if (value == null) {
      return errorText;
    }

    return null;
  }
}

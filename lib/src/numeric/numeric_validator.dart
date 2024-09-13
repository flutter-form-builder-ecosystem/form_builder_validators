import '../../form_builder_validators.dart';

/// {@template numeric_validator_template}
/// [NumericValidator] extends [TranslatedValidator] to validate if a value is numeric.
///
/// This validator checks if the value is a number or a string that can be parsed into a number.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class NumericValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the numeric validator.
  const NumericValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.numericErrorText;

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

    return value == null ? errorText : null;
  }
}

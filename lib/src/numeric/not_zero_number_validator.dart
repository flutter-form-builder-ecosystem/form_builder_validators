import '../../form_builder_validators.dart';

/// {@template not_zero_number_validator_template}
/// [NotZeroNumberValidator] extends [TranslatedValidator] to validate if a value is not zero.
///
/// This validator checks if the value is a number or a string that can be parsed into a number and ensures it is not zero.
///
/// ## Parameters:
///
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class NotZeroNumberValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the not zero number validator.
  const NotZeroNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.notZeroNumberErrorText;

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

    if (value == 0) {
      return errorText;
    }

    return null;
  }
}

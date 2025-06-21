import '../../form_builder_validators.dart';

/// {@template min_length_validator_template}
/// [MinLengthValidator] extends [TranslatedValidator] to validate if a value meets a specified minimum length.
///
/// This validator works with various types, including String, Iterable, and Map.
///
/// ## Parameters:
///
/// - [minLength] The minimum length the value is required to have.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MinLengthValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the minimum length validator.
  const MinLengthValidator(
    this.minLength, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The minimum length the value is required to have.
  final int minLength;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.minLengthErrorText(minLength);

  @override
  String? validateValue(T valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength < minLength ? errorText : null;
  }
}

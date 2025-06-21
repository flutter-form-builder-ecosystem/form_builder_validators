import '../../form_builder_validators.dart';

/// {@template max_length_validator_template}
/// [MaxLengthValidator] extends [TranslatedValidator] to validate if a value does not exceed a specified maximum length.
///
/// This validator works with various types, including String, Iterable, and Map.
///
/// ## Parameters:
///
/// - [maxLength] The maximum length the value is allowed to have.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class MaxLengthValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the maximum length validator.
  const MaxLengthValidator(
    this.maxLength, {

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The maximum length the value is allowed to have.
  final int maxLength;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxLengthErrorText(maxLength);

  @override
  String? validateValue(T valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength > maxLength ? errorText : null;
  }
}

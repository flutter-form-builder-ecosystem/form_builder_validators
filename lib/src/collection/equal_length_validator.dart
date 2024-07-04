import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template equal_length_validator_template}
/// [EqualLengthValidator] extends [BaseValidator] to validate if a value has a specified length.
///
/// This validator works with various types, including String, Iterable, and Map.
///
/// ## Parameters:
///
/// - [length] The exact length the value should have.
/// - [allowEmpty] Whether to allow empty values.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class EqualLengthValidator<T> extends BaseValidator<T> {
  /// Constructor for the equal length validator.
  const EqualLengthValidator(
    this.length, {
    this.allowEmpty = false,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The exact length the value should have.
  final int length;

  /// Whether to allow empty values.
  final bool allowEmpty;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.equalLengthErrorText(length);

  @override
  String? validateValue(T valueCandidate) {
    int valueLength = 0;

    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    if (valueCandidate is Map) valueLength = valueCandidate.length;

    return valueLength != length && (!allowEmpty || valueLength > 0)
        ? errorText
        : null;
  }
}

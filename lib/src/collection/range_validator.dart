import '../../form_builder_validators.dart';

/// {@template range_validator_template}
/// [RangeValidator] extends [TranslatedValidator] to validate if a value falls within a specified range.
///
/// This validator works with various types, including numeric types and collections.
///
/// ## Parameters:
///
/// - [min] The minimum value of the range.
/// - [max] The maximum value of the range.
/// - [inclusive] Whether the range is inclusive of the min and max values.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// This validator uses [MinValidator], [MaxValidator], [MinLengthValidator], and [MaxLengthValidator] internally.
///
/// {@endtemplate}
class RangeValidator<T> extends TranslatedValidator<T> {
  /// Constructor for the range validator.
  RangeValidator(
    this.min,
    this.max, {
    this.inclusive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  })  : _minValidator = MinValidator<T>(
          min,
          inclusive: inclusive,
          errorText: errorText,
          checkNullOrEmpty: checkNullOrEmpty,
        ),
        _maxValidator = MaxValidator<T>(
          max,
          inclusive: inclusive,
          errorText: errorText,
          checkNullOrEmpty: checkNullOrEmpty,
        ),
        _minLengthValidator = MinLengthValidator<T>(
          min.toInt(),
          errorText: errorText,
          checkNullOrEmpty: checkNullOrEmpty,
        ),
        _maxLengthValidator = MaxLengthValidator<T>(
          max.toInt(),
          errorText: errorText,
          checkNullOrEmpty: checkNullOrEmpty,
        );

  /// The minimum value of the range.
  final num min;

  /// The maximum value of the range.
  final num max;

  /// Whether the range is inclusive of the min and max values.
  final bool inclusive;

  /// Internal minimum value validator.
  final MinValidator<T> _minValidator;

  /// Internal maximum value validator.
  final MaxValidator<T> _maxValidator;

  /// Internal minimum length validator.
  final MinLengthValidator<T> _minLengthValidator;

  /// Internal maximum length validator.
  final MaxLengthValidator<T> _maxLengthValidator;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.betweenErrorText(min, max);

  @override
  String? validateValue(T valueCandidate) {
    final String? minResult = _minValidator.validate(valueCandidate);
    final String? maxResult = _maxValidator.validate(valueCandidate);
    final String? minLengthResult =
        _minLengthValidator.validate(valueCandidate);
    final String? maxLengthResult =
        _maxLengthValidator.validate(valueCandidate);

    if ((minResult == null && maxResult == null) ||
        (minLengthResult == null && maxLengthResult == null)) {
      return null;
    } else {
      return errorText;
    }
  }
}

import '../../form_builder_validators.dart';

class RangeValidator<T> extends BaseValidator<T> {
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

  final num min;

  final num max;

  final bool inclusive;

  final MinValidator<T> _minValidator;

  final MaxValidator<T> _maxValidator;

  final MinLengthValidator<T> _minLengthValidator;

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

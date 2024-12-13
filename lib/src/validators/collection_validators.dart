import '../../localization/l10n.dart';
import 'constants.dart';

/// Returns a [Validator] function that checks if its input has a length that is
/// greater than or equal to `minLength`. If the input satisfies this condition,
/// the validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.minLengthErrorText(minLength)`,
/// if [minLengthMsg] is not provided.
///
/// # Caveats
/// - Objects that are not collections are considered as collections with
/// length 1.
///
/// # Errors
/// - Throws [AssertionError] if `minLength` is negative.
Validator<T> minLength<T extends Object>(int minLength,
    {String Function(int)? minLengthMsg}) {
  assert(minLength >= 0, 'The "minLength" parameter may not be negative');
  return (T value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength < minLength
        ? minLengthMsg?.call(minLength) ??
            FormBuilderLocalizations.current.minLengthErrorText(minLength)
        : null;
  };
}

/// Returns a [Validator] function that checks if its input has a length that is
/// less than or equal to `maxLength`. If the input satisfies this condition,
/// the validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.maxLengthErrorText(maxLength)`,
/// if [maxLengthMsg] is not provided.
///
/// # Caveats
/// - Objects that are not collections are considered as collections with
/// length 1.
///
/// # Errors
/// - Throws [AssertionError] if `maxLength` is negative.
Validator<T> maxLength<T extends Object>(int maxLength,
    {String Function(int)? maxLengthMsg}) {
  assert(maxLength >= 0, 'The "maxLength" parameter may not be negative');
  return (T value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength > maxLength
        ? maxLengthMsg?.call(maxLength) ??
            FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
        : null;
  };
}

/// Temporary error message for `betweenLength` validator.
String betweenLengthTemporaryErrorMessage(
        {required int min, required int max}) =>
    'Value must have a length that is between $min and $max, inclusive';

/// Returns a [Validator] function that checks if its input has a length that is
/// between `minLength` and `maxLength`, inclusive. If the input satisfies this
/// condition, the validator returns `null`. Otherwise, it returns the default
/// error message
/// `FormBuilderLocalizations.current.betweenLengthErrorText(minLength, maxLength)`,
/// if [betweenLengthMsg] is not provided.
///
/// # Caveats
/// - Objects that are not collections are considered as collections with
/// length 1.
///
/// # Errors
/// - Throws [AssertionError] if `minLength` or `maxLength` are negative.
/// - Throws [AssertionError] if `maxLength` is less than `minLength`.
Validator<T> betweenLength<T extends Object>(
  int minLength,
  int maxLength, {
  String Function({required int min, required int max})? betweenLengthMsg,
}) {
  assert(minLength >= 0, 'The "minLength" parameter may not be negative');
  assert(maxLength >= minLength,
      'The "maxLength" parameter must be greater than or equal to "minLength"');
  return (T value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return (valueLength < minLength || valueLength > maxLength)
        ? betweenLengthMsg?.call(min: minLength, max: maxLength) ??
            // TODO (ArturAssisComp): add the translated version of this message
            // FormBuilderLocalizations.current.betweenLengthErrorText(maxLength)
            betweenLengthTemporaryErrorMessage(min: minLength, max: maxLength)
        : null;
  };
}

/// Returns a [Validator] function that checks if its input has the length equals
/// to the provided positional parameter `length`. If the input satisfies this
/// condition, the validator returns `null`. Otherwise, it returns the default
/// error message `FormBuilderLocalizations.current.equalLengthErrorText(length)`,
/// if [equalLengthMsg] is not provided.
///
/// # Caveats
/// - Objects that are not collections are considered as collections with
/// length 1.
///
/// # Errors
/// - Throws [AssertionError] if `length` is negative.
/// - Throws [AssertionError] if `allowEmpty` is `false` and `length` is 0.
Validator<T> equalLength<T extends Object>(int length,
    {bool allowEmpty = false, String Function(int)? equalLengthMsg}) {
  assert(length >= 0, 'The length parameter may not be negative');
  assert(!(!allowEmpty && length == 0),
      'If empty is not allowed, the target length may not be 0.');
  final String errorMsg = equalLengthMsg?.call(length) ??
      FormBuilderLocalizations.current.equalLengthErrorText(length);
  return (T value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;
    return valueLength == length || (allowEmpty && valueLength == 0)
        ? null
        : errorMsg;
  };
}

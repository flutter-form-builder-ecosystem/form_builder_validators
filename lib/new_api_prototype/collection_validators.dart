import '../localization/l10n.dart';
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

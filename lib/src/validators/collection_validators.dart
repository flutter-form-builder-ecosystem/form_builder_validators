import '../../localization/l10n.dart';
import 'constants.dart';

/// {@template validator_min_length}
/// Creates a validator function that checks if the input's length is greater
/// than or equal to `min`. The validator returns `null` for valid input and an
/// error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [minLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.minLengthErrorText(min)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` and can be a
///   `String`, `Iterable`, `Map`, or other object type.
///
/// ## Parameters
/// - `min` (`int`): The minimum length required. Must be non-negative.
/// - `minLengthMsg` (`String Function(T input, int min)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   minimum length required and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<T>` function that takes an input of type T and returns:
/// - `null` if the input's length is greater than or equal to [min]
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is negative
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = minLength<String>(3);
/// print(stringValidator('abc')); // Returns null
/// print(stringValidator('ab')); // Returns error message
///
/// // List validation
/// final listValidator = minLength<List>(2);
/// print(listValidator([1, 2, 3])); // Returns null
/// print(listValidator([1])); // Returns error message
///
/// // Custom error message
/// final customValidator = minLength<String>(
///   5,
///   minLengthMsg: (_, min) => 'Text must be at least $min chars long!',
/// );
/// ```
///
/// ## Caveats
/// - Non-collection objects (those that are neither String, Iterable, nor Map)
///   are treated as having a length of 1
/// {@endtemplate}
Validator<T> minLength<T extends Object>(int min,
    {String Function(T input, int min)? minLengthMsg}) {
  assert(min >= 0, 'The "minLength" parameter may not be negative');
  return (T input) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    }

    return valueLength < min
        ? minLengthMsg?.call(input, min) ??
            FormBuilderLocalizations.current.minLengthErrorText(min)
        : null;
  };
}

/// {@template validator_max_length}
/// Creates a validator function that checks if the input's length is less than
/// or equal to `max`. The validator returns `null` for valid input and an
/// error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [maxLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.maxLengthErrorText(max)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` and can be a
///   `String`, `Iterable`, `Map`, or other object type.
///
/// ## Parameters
/// - `max` (`int`): The maximum length allowed. Must be non-negative.
/// - `maxLengthMsg` (`String Function(T input, int max)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   maximum length allowed and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<T>` function that takes an input of type T and returns:
/// - `null` if the input's length is less than or equal to [max]
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [max] is negative
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = maxLength<String>(5);
/// print(stringValidator('hello')); // Returns null
/// print(stringValidator('too long')); // Returns error message
///
/// // List validation
/// final listValidator = maxLength<List>(3);
/// print(listValidator([1, 2])); // Returns null
/// print(listValidator([1, 2, 3, 4])); // Returns error message
///
/// // Custom error message
/// final customValidator = maxLength<String>(
///   3,
///   maxLengthMsg: (_, max) => 'Text cannot exceed $max characters!',
/// );
/// ```
///
/// ## Caveats
/// - Non-collection objects (those that are neither String, Iterable, nor Map)
///   are treated as having a length of 1
/// {@endtemplate}
Validator<T> maxLength<T extends Object>(int max,
    {String Function(T input, int max)? maxLengthMsg}) {
  assert(max >= 0, 'The "maxLength" parameter may not be negative');
  return (T input) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    }

    return valueLength > max
        ? maxLengthMsg?.call(input, max) ??
            FormBuilderLocalizations.current.maxLengthErrorText(max)
        : null;
  };
}

/// {@template validator_between_length}
/// Creates a validator function that checks if the input's length falls within
/// an inclusive range between `min` and `max`. The validator returns `null` for
/// valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [betweenLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.betweenLengthErrorText(min, max)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` and can be a
///   `String`, `Iterable`, `Map`, or other object type.
///
/// ## Parameters
/// - `min` (`int`): The minimum length allowed. Must be non-negative.
/// - `max` (`int`): The maximum length allowed. Must be greater than or equal
///   to [min].
/// - `betweenLengthMsg` (`String Function(T input, {required int min, required int max})?`):
///   Optional function to generate custom error messages. Receives the input and
///   the minimum and maximum lengths allowed, and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<T>` function that takes an input of type T and returns:
/// - `null` if the input's length is between [min] and [max] inclusive
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is negative
/// - `AssertionError`: When [max] is less than [min]
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = betweenLength<String>(3, 5);
/// print(stringValidator('hi')); // Returns error message
/// print(stringValidator('hello')); // Returns null
/// print(stringValidator('too long')); // Returns error message
///
/// // List validation
/// final listValidator = betweenLength<List>(2, 4);
/// print(listValidator([1])); // Returns error message
/// print(listValidator([1, 2, 3])); // Returns null
///
/// // Custom error message
/// final customValidator = betweenLength<String>(
///   2,
///   4,
///   betweenLengthMsg: (input, {required min, required max}) =>
///     'Text must be between $min and $max characters!',
/// );
/// ```
///
/// ## Caveats
/// - Non-collection objects (those that are neither String, Iterable, nor Map)
///   are treated as having a length of 1
/// {@endtemplate}
Validator<T> betweenLength<T extends Object>(
  int min,
  int max, {
  String Function(T input, {required int min, required int max})?
      betweenLengthMsg,
}) {
  assert(min >= 0, 'The "minLength" parameter may not be negative');
  assert(max >= min,
      'The "maxLength" parameter must be greater than or equal to "minLength"');
  return (T input) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    }

    return (valueLength < min || valueLength > max)
        ? betweenLengthMsg?.call(input, min: min, max: max) ??
            FormBuilderLocalizations.current.betweenLengthErrorText(min, max)
        : null;
  };
}

/// {@template validator_equal_length}
/// Creates a validator function that checks if the input's length equals exactly
/// the specified `expectedLength`. The validator returns `null` for valid input
/// and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [equalLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.equalLengthErrorText(expectedLength)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` and can be a
///   `String`, `Iterable`, `Map`, or other object type.
///
/// ## Parameters
/// - `expectedLength` (`int`): The exact length required. Must be non-negative.
/// - `allowEmpty` (`bool`): When `true`, allows empty inputs (length 0) to pass
///   validation even if `expectedLength` is not 0. Defaults to `false`.
/// - `equalLengthMsg` (`String Function(T input, int expectedLength)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   expected length and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<T>` function that takes an input of type T and returns:
/// - `null` if the input's length equals [expectedLength], or if [allowEmpty] is
///   `true` and the input is empty
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [expectedLength] is negative
/// - `AssertionError`: When [allowEmpty] is `false` and [expectedLength] is 0
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = equalLength<String>(5);
/// print(stringValidator('hello')); // Returns null
/// print(stringValidator('hi')); // Returns error message
///
/// // List validation with empty allowed
/// final listValidator = equalLength<List>(3, allowEmpty: true);
/// print(listValidator([])); // Returns null
/// print(listValidator([1, 2, 3])); // Returns null
/// print(listValidator([1, 2])); // Returns error message
///
/// // Custom error message
/// final customValidator = equalLength<String>(
///   4,
///   equalLengthMsg: (_, length) => 'Text must be exactly $length characters!',
/// );
/// ```
///
/// ## Caveats
/// - Non-collection objects (those that are neither String, Iterable, nor Map)
///   are treated as having a length of 1
/// {@endtemplate}
Validator<T> equalLength<T extends Object>(int expectedLength,
    {bool allowEmpty = false,
    String Function(T input, int expectedLength)? equalLengthMsg}) {
  assert(expectedLength >= 0, 'The length parameter may not be negative');
  assert(!(!allowEmpty && expectedLength == 0),
      'If empty is not allowed, the target length may not be 0.');
  return (T input) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    }

    final String errorMsg = equalLengthMsg?.call(input, expectedLength) ??
        FormBuilderLocalizations.current.equalLengthErrorText(expectedLength);
    return valueLength == expectedLength || (allowEmpty && valueLength == 0)
        ? null
        : errorMsg;
  };
}

import '../../localization/l10n.dart';
import 'constants.dart';

/// {@template validator_min_length}
/// Creates a validator function that checks if the input collection's length is
/// greater than or equal to `min`. The validator returns `null` for valid input
/// and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [minLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.minLengthErrorText(min)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must be a collection, in other words,
/// it must be one of `String`, `Iterable` or `Map`.
///
/// ## Parameters
/// - `min` (`int`): The minimum length required. Must be non-negative.
/// - `minLengthMsg` (`String Function(T input, int min)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   minimum length required and returns an error message string.
///
/// ## Return Value
/// A `Validator<T>` function that produces:
/// - `null` for valid inputs (length >= min)
/// - An error message string for invalid inputs (length < min)
///
/// ## Throws
/// - `ArgumentError` when:
///   - [min] is negative
///   - input runtime type is not a collection
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
/// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
/// While the compiler cannot enforce this restriction, it is the developer's
/// responsibility to maintain this constraint.
/// - The validator treats non-collection inputs as implementation errors rather
/// than validation failures. Validate input types before passing them to
/// this validator.
/// {@endtemplate}
Validator<T> minLength<T extends Object>(int min,
    {String Function(T input, int min)? minLengthMsg}) {
  if (min < 0) {
    throw ArgumentError.value(min, 'min', 'This argument may not be negative');
  }
  return (T input) {
    int valueLength;
    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }
    return valueLength < min
        ? minLengthMsg?.call(input, min) ??
            FormBuilderLocalizations.current.minLengthErrorText(min)
        : null;
  };
}

/// {@template validator_max_length}
/// Creates a validator function that checks if the input collection's length is
/// less than or equal to max. The validator returns null for valid input
/// and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [maxLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.maxLengthErrorText(max)`.
///
/// ## Type Parameters
/// - T: The type of input to validate. Must be a collection, in other words,
/// it must be one of `String`, `Iterable` or `Map`.
///
/// ## Parameters
/// - `max` (`int`): The maximum length allowed. Must be non-negative.
/// - `maxLengthMsg` (`String Function(T input, int max)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   maximum length allowed and returns an error message string.
///
/// ## Return Value
/// A `Validator<T>` function that produces:
/// - null for valid inputs (length <= max)
/// - An error message string for invalid inputs (length > max)
///
/// ## Throws
/// - `ArgumentError` when:
///   - [max] is negative
///   - input runtime type is not a collection
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = maxLength<String>(5);
/// print(stringValidator('hello')); // Returns null
/// print(stringValidator('hello world')); // Returns error message
///
/// // List validation
/// final listValidator = maxLength<List>(3);
/// print(listValidator([1, 2])); // Returns null
/// print(listValidator([1, 2, 3, 4])); // Returns error message
///
/// // Custom error message
/// final customValidator = maxLength<String>(
///   10,
///   maxLengthMsg: (_, max) => 'Text must not exceed $max chars!',
/// );
/// ```
/// ## Caveats
/// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
/// While the compiler cannot enforce this restriction, it is the developer's
/// responsibility to maintain this constraint.
/// - The validator treats non-collection inputs as implementation errors rather
/// than validation failures. Validate input types before passing them to
/// this validator.
/// {@endtemplate}
Validator<T> maxLength<T extends Object>(int max,
    {String Function(T input, int max)? maxLengthMsg}) {
  if (max < 0) {
    throw ArgumentError.value(max, 'max', 'This argument may not be negative');
  }
  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }

    return valueLength > max
        ? maxLengthMsg?.call(input, max) ??
            FormBuilderLocalizations.current.maxLengthErrorText(max)
        : null;
  };
}

/// {@template validator_between_length}
/// Creates a validator function that checks if the input collection's length falls
/// within an inclusive range defined by `min` and `max`. The validator returns
/// `null` for valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [betweenLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.betweenLengthErrorText(min, max)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must be a collection, in other words,
/// it must be one of `String`, `Iterable` or `Map`.
///
/// ## Parameters
/// - `min` (`int`): The minimum length required. Must be non-negative.
/// - `max` (`int`): The maximum length allowed. Must be greater than or equal
///   to `min`.
/// - `betweenLengthMsg` (`String Function(T input, {required int min, required int max})?`):
///   Optional function to generate custom error messages. Receives the input and the
///   minimum and maximum lengths required, returning an error message string.
///
/// ## Return Value
/// A `Validator<T>` function that produces:
/// - `null` for valid inputs (min <= length <= max)
/// - An error message string for invalid inputs (length < min || length > max)
///
/// ## Throws
/// - `ArgumentError` when:
///   - [min] is negative
///   - [max] is less than [min]
///   - input runtime type is not a collection
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = betweenLength<String>(3, 5);
/// print(stringValidator('abc')); // Returns null
/// print(stringValidator('ab')); // Returns error message
/// print(stringValidator('abcdef')); // Returns error message
///
/// // List validation
/// final listValidator = betweenLength<List>(2, 4);
/// print(listValidator([1, 2, 3])); // Returns null
/// print(listValidator([1])); // Returns error message
/// print(listValidator([1, 2, 3, 4, 5])); // Returns error message
///
/// // Custom error message
/// final customValidator = betweenLength<String>(
///   5,
///   10,
///   betweenLengthMsg: (_, {required min, required max}) =>
///     'Text must be between $min and $max chars long!',
/// );
/// ```
///
/// ## Caveats
/// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
/// While the compiler cannot enforce this restriction, it is the developer's
/// responsibility to maintain this constraint.
/// - The validator treats non-collection inputs as implementation errors rather
/// than validation failures. Validate input types before passing them to
/// this validator.
/// {@endtemplate}
Validator<T> betweenLength<T extends Object>(
  int min,
  int max, {
  String Function(T input, {required int min, required int max})?
      betweenLengthMsg,
}) {
  if (min < 0) {
    throw ArgumentError.value(min, 'min', 'This argument may not be negative');
  }
  if (max < min) {
    throw ArgumentError.value(
      max,
      'max',
      'This argument must be greater than or equal to "min" length ($min)',
    );
  }
  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }
    return (valueLength < min || valueLength > max)
        ? betweenLengthMsg?.call(input, min: min, max: max) ??
            FormBuilderLocalizations.current.betweenLengthErrorText(min, max)
        : null;
  };
}

/// {@template validator_equal_length}
/// Creates a validator function that checks if the input collection's length equals
/// the specified length. The validator returns `null` for valid input and an error
/// message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [equalLengthMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.equalLengthErrorText(expectedLength)`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must be a collection, in other words,
/// it must be one of `String`, `Iterable` or `Map`.
///
/// ## Parameters
/// - `expectedLength` (`int`): The exact length required. Must be non-negative.
/// - `equalLengthMsg` (`String Function(T input, int expectedLength)?`): Optional
///   function to generate custom error messages. Receives the input and the
///   expected length, returning an error message string.
///
/// ## Return Value
/// A `Validator<T>` function that produces:
/// - `null` for valid inputs (length == expectedLength)
/// - An error message string for invalid inputs (length != expectedLength)
///
/// ## Throws
/// - `ArgumentError` when:
///   - [expectedLength] is negative
///   - input runtime type is not a collection
///
/// ## Examples
/// ```dart
/// // String validation
/// final stringValidator = equalLength<String>(3);
/// print(stringValidator('abc')); // Returns null
/// print(stringValidator('ab')); // Returns error message
/// print(stringValidator('abcd')); // Returns error message
///
/// // List validation
/// final listValidator = equalLength<List>(2);
/// print(listValidator([1, 2])); // Returns null
/// print(listValidator([1])); // Returns error message
/// print(listValidator([1, 2, 3])); // Returns error message
///
/// // Custom error message
/// final customValidator = equalLength<String>(
///   5,
///   equalLengthMsg: (_, expectedLength) =>
///     'Text must be exactly $expectedLength chars long!',
/// );
/// ```
///
/// ## Caveats
/// - Type parameter `T` must be restricted to `String`, `Map`, or `Iterable`.
/// While the compiler cannot enforce this restriction, it is the developer's
/// responsibility to maintain this constraint.
/// - The validator treats non-collection inputs as implementation errors rather
/// than validation failures. Validate input types before passing them to
/// this validator.
/// {@endtemplate}
Validator<T> equalLength<T extends Object>(int expectedLength,
    {String Function(T input, int expectedLength)? equalLengthMsg}) {
  if (expectedLength < 0) {
    throw ArgumentError.value(
        expectedLength, 'expectedLength', 'This argument may not be negative');
  }

  return (T input) {
    int valueLength;

    if (input is String) {
      valueLength = input.length;
    } else if (input is Iterable) {
      valueLength = input.length;
    } else if (input is Map) {
      valueLength = input.length;
    } else {
      throw ArgumentError.value(
        input,
        'input',
        'Input must be a collection (String, Iterable, or Map). Received type "${input.runtimeType}"',
      );
    }

    return valueLength != expectedLength
        ? equalLengthMsg?.call(input, expectedLength) ??
            FormBuilderLocalizations.current
                .equalLengthErrorText(expectedLength)
        : null;
  };
}

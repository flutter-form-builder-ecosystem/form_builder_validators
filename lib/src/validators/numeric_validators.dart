import '../../localization/l10n.dart';
import 'constants.dart';

/// {@template validator_greater_than}
/// Creates a validator function that checks if a numeric input exceeds `reference`.
///
/// ## Type Parameters
/// - `T`: A numeric type that extends [num], allowing `int`, `double` or
/// `num` validations
///
/// ## Parameters
/// - `reference` (`T`): The threshold value that the input must exceed
/// - `greaterThanMsg` (`String Function(T input, T reference)?`): Optional custom error
///   message generator that takes the input value and threshold as parameters
///
/// ## Returns
/// Returns a [Validator] function that:
/// - Returns `null` if the input is greater than the threshold value `reference`
/// - Returns an error message string if validation fails, either from the custom
///   `greaterThanMsg` function or the default localized error text
///
/// ## Examples
/// ```dart
/// // Basic usage with integers
/// final ageValidator = greaterThan<int>(18);
///
/// // Custom error message
/// final priceValidator = greaterThan<double>(
///   0.0,
///   greaterThanMsg: (_, ref) => 'Price must be greater than \$${ref.toStringAsFixed(2)}',
/// );
/// ```
///
/// ## Caveats
/// - The validator uses strict greater than comparison (`>`)
/// {@endtemplate}
Validator<T> greaterThan<T extends num>(T reference,
    {String Function(T input, T reference)? greaterThanMsg}) {
  return (T input) {
    return input > reference
        ? null
        : greaterThanMsg?.call(input, reference) ??
            FormBuilderLocalizations.current.greaterThanErrorText(reference);
  };
}

/// {@template validator_greater_than_or_equal_to}
/// Creates a validator function that checks if a numeric input is greater than
/// or equal to `reference`.
///
/// ## Type Parameters
/// - `T`: A numeric type that extends [num], allowing `int`, `double` or
/// `num` validations
///
/// ## Parameters
/// - `reference` (`T`): The threshold value that the input must be greater than or equal to
/// - `greaterThanOrEqualToMsg` (`String Function(T input, T reference)?`): Optional custom error
///   message generator that takes the input value and threshold as parameters
///
/// ## Returns
/// Returns a [Validator] function that:
/// - Returns `null` if the input is greater than or equal to the threshold value
/// `reference`
/// - Returns an error message string if validation fails, either from the custom
///   `greaterThanOrEqualToMsg` function or the default localized error text from
///   [FormBuilderLocalizations]
///
/// ## Examples
/// ```dart
/// // Basic usage with integers
/// final ageValidator = greaterThanOrEqualTo<int>(18);
///
/// // Custom error message
/// final priceValidator = greaterThanOrEqualTo<double>(
///   0.0,
///   greaterThanOrEqualToMsg: (_, ref) => 'Price must be at least \$${ref.toStringAsFixed(2)}',
/// );
/// ```
///
/// ## Caveats
/// - The validator uses greater than or equal to comparison (`>=`)
/// {@endtemplate}
Validator<T> greaterThanOrEqualTo<T extends num>(T reference,
    {String Function(T input, T reference)? greaterThanOrEqualToMsg}) {
  return (T input) {
    return input >= reference
        ? null
        : greaterThanOrEqualToMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .greaterThanOrEqualToErrorText(reference);
  };
}

/// {@template validator_less_than}
/// Creates a validator function that checks if a numeric input is less than `reference`.
///
/// ## Type Parameters
/// - `T`: A numeric type that extends [num], allowing `int`, `double` or
/// `num` validations
///
/// ## Parameters
/// - `reference` (`T`): The threshold value that the input must be less than
/// - `lessThanMsg` (`String Function(T input, T reference)?`): Optional custom error
///   message generator that takes the input value and threshold as parameters
///
/// ## Returns
/// Returns a [Validator] function that:
/// - Returns `null` if the input is less than the threshold value `reference`
/// - Returns an error message string if validation fails, either from the custom
///   `lessThanMsg` function or the default localized error text
///
/// ## Examples
/// ```dart
/// // Basic usage with integers
/// final maxAgeValidator = lessThan<int>(100);
///
/// // Custom error message
/// final discountValidator = lessThan<double>(
///   1.0,
///   lessThanMsg: (_, ref) => 'Discount must be less than ${(ref * 100).toStringAsFixed(0)}%',
/// );
/// ```
///
/// ## Caveats
/// - The validator uses strict less than comparison (`<`)
/// {@endtemplate}
Validator<T> lessThan<T extends num>(T reference,
    {String Function(T input, T reference)? lessThanMsg}) {
  return (T input) {
    return input < reference
        ? null
        : lessThanMsg?.call(input, reference) ??
            FormBuilderLocalizations.current.lessThanErrorText(reference);
  };
}

/// {@template validator_less_than_or_equal_to}
/// Creates a validator function that checks if a numeric input is less than
/// or equal to `reference`.
///
/// ## Type Parameters
/// - `T`: A numeric type that extends [num], allowing `int`, `double` or
/// `num` validations
///
/// ## Parameters
/// - `reference` (`T`): The threshold value that the input must be less than or equal to
/// - `lessThanOrEqualToMsg` (`String Function(T input, T reference)?`): Optional custom error
///   message generator that takes the input value and threshold as parameters
///
/// ## Returns
/// Returns a [Validator] function that:
/// - Returns `null` if the input is less than or equal to the threshold value
/// `reference`
/// - Returns an error message string if validation fails, either from the custom
///   `lessThanOrEqualToMsg` function or the default localized error text from
///   [FormBuilderLocalizations]
///
/// ## Examples
/// ```dart
/// // Basic usage with integers
/// final maxAgeValidator = lessThanOrEqualTo<int>(100);
///
/// // Custom error message
/// final maxPriceValidator = lessThanOrEqualTo<double>(
///   999.99,
///   lessThanOrEqualToMsg: (_, ref) => 'Price cannot exceed \$${ref.toStringAsFixed(2)}',
/// );
/// ```
///
/// ## Caveats
/// - The validator uses less than or equal to comparison (`<=`)
/// {@endtemplate}
Validator<T> lessThanOrEqualTo<T extends num>(T reference,
    {String Function(T input, T reference)? lessThanOrEqualToMsg}) {
  return (T input) {
    return input <= reference
        ? null
        : lessThanOrEqualToMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .lessThanOrEqualToErrorText(reference);
  };
}

/// {@template validator_between}
/// Creates a validator function that checks if a numeric input falls within a specified
/// range defined by `min` and `max` values.
///
/// ## Type Parameters
/// - `T`: A numeric type that extends [num], allowing `int`, `double` or
/// `num` validations
///
/// ## Parameters
/// - `min` (`T`): The lower bound of the valid range
/// - `max` (`T`): The upper bound of the valid range
/// - `minInclusive` (`bool`): Determines if the lower bound is inclusive. Defaults to `true`
/// - `maxInclusive` (`bool`): Determines if the upper bound is inclusive. Defaults to `true`
/// - `betweenMsg` (`String Function(T input, T min, T max, bool minInclusive, bool maxInclusive)?`):
///   Optional custom error message generator that takes the input value, inclusivity flags,
///   and range bounds as parameters
///
///
/// ## Returns
/// Returns a [Validator] function that:
/// - Returns `null` if the input falls within the specified range according to the
///   inclusivity settings
/// - Returns an error message string if validation fails, either from the custom
///   `betweenMsg` function or the default localized error text from
///   [FormBuilderLocalizations]
///
/// ## Throw
/// - `AssertionError`: when `max` is not greater than or equal to `min`.
///
/// ## Examples
/// ```dart
/// // Basic usage with inclusive bounds
/// final ageValidator = between<int>(18, 65); // [18, 65]
///
/// // Exclusive upper bound for decimal values
/// final priceValidator = between<double>( // [0.0, 100.0)
///   0.0,
///   100.0,
///   maxInclusive: false,
/// );
///
/// // Custom error message
/// final scoreValidator = between<double>( //
///   0.0,
///   10.0,
///   betweenMsg: (_, min, max, __, ___) =>
///     'Score must be between $min and $max (inclusive)',
/// );
/// ```
///
/// ## Caveats
/// - The default behavior uses inclusive bounds (`>=` and `<=`)
/// {@endtemplate}
Validator<T> between<T extends num>(T min, T max,
    {bool minInclusive = true,
    bool maxInclusive = true,
    String Function(
      T input,
      T min,
      T max,
      bool minInclusive,
      bool maxInclusive,
    )? betweenMsg}) {
  // TODO(ArturAssisComp): transform this assertion into an ArgumentError.value call
  assert(min <= max, 'Min must be less than or equal to max');
  return (T input) {
    return (minInclusive ? input >= min : input > min) &&
            (maxInclusive ? input <= max : input < max)
        ? null
        : betweenMsg?.call(
              input,
              min,
              max,
              minInclusive,
              maxInclusive,
            ) ??
            FormBuilderLocalizations.current.betweenNumErrorText(
                min, max, minInclusive.toString(), maxInclusive.toString());
  };
}

// other possible validators: isPositive/isNegative, isMultipleOf, etc.

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

String lessThanTmpMsg(num n) => 'Value must be less than $n';

/// This function returns a validator that checks whether the user input is less
/// than `n`. If the input is valid, the validator returns `null`. Otherwise, it
/// returns an error message. The error message is `lessThanMsg`, or
/// `FormBuilderLocalizations.current.lessThan(n)` if `lessThanMsg`
/// was not provided.
Validator<T> lessThan<T extends num>(T n, {String Function(num)? lessThanMsg}) {
  return (T value) {
    return value < n ? null : lessThanMsg?.call(n) ?? lessThanTmpMsg(n);
  };
}

String lessThanOrEqualToTmpMsg(num n) =>
    'Value must be less than or equal to $n';

/// This function returns a validator that checks whether the user input is less
/// than or equal to `n`. If the input is valid, the validator returns `null`. Otherwise, it
/// returns an error message. The error message is `lessThanOrEqualMsg`, or
/// `FormBuilderLocalizations.current.lessThanOrEqualTo(n)` if `lessThanOrEqualToMsg`
/// was not provided.
Validator<T> lessThanOrEqualTo<T extends num>(T n,
    {String Function(num)? lessThanOrEqualToMsg}) {
  return (T value) {
    return value <= n
        ? null
        : lessThanOrEqualToMsg?.call(n) ?? lessThanOrEqualToTmpMsg(n);
  };
}

String betweenTmpMsg(
        bool leftInclusive, bool rightInclusive, num min, num max) =>
    'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$min and less than ${rightInclusive ? 'or equal to ' : ''}$max';

/// This function returns a validator that checks if the user input is between
/// `min` and `max`.
///
/// The comparison will be inclusive by default, but this behavior
/// can be changed by editing `leftInclusive` and `rightInclusive`.
///
/// If the input is valid, it returns `null`. Otherwise,
/// it returns an error message that is `betweenMsg`, or
/// `FormBuilderLocalizations.current.between(min, max)` if `betweenMsg`
/// was not provided.
Validator<T> between<T extends num>(T min, T max,
    {bool leftInclusive = true,
    bool rightInclusive = true,
    String Function(bool? leftInclusive, bool rightInclusive, num min, num max)?
        betweenMsg}) {
  assert(min <= max, 'Min must be less than or equal to max');
  return (T value) {
    return (leftInclusive ? value >= min : value > min) &&
            (rightInclusive ? value <= max : value < max)
        ? null
        : betweenMsg?.call(leftInclusive, rightInclusive, min, max) ??
            'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$min and less than ${rightInclusive ? 'or equal to ' : ''}$max';
  };
}

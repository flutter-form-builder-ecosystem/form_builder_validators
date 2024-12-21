import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_is_equal}
/// Creates a validator that checks if a given input matches `value` using
/// the equality (`==`) operator.
///
///
/// ## Parameters
/// - `value` (`T`): The target value to compare against the input. This serves as
///   the reference for equality checking.
/// - `isEqualMsg` (`String Function(String)?`): Optional custom error message
///   generator. Takes the string representation of the target value and returns
///   a custom error message.
///
///
/// ## Type Parameters
/// - `T`: The type of value being validated. Must extend `Object?` to allow for
///   nullable types.
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if the input matches the target value
/// - Returns an error message if the values don't match, either from the custom
///   `isEqualMsg` function or the default localized error text.
///
/// ## Examples
/// ```dart
/// // Basic usage for password confirmation
/// final passwordConfirmValidator = isEqual(password);
///
/// // Using custom error message
/// final specificValueValidator = isEqual<int>(
///   42,
///   isEqualMsg: (value) => 'Value must be exactly $value',
/// );
/// ```
///
/// ## Caveats
/// - The comparison uses the `==` operator, which may not be suitable for complex
///   objects without proper equality implementation
/// - The error message uses the string representation of the value via
///   `toString()`, which might not be ideal for all types
/// {@endtemplate}
Validator<T> isEqual<T extends Object?>(
  T value, {
  String Function(String)? isEqualMsg,
}) {
  return (T input) {
    final String valueString = value.toString();
    return value == input
        ? null
        : isEqualMsg?.call(valueString) ??
            FormBuilderLocalizations.current.equalErrorText(valueString);
  };
}

/// {@template validator_is_not_equal}
/// Creates a validator that checks if a given input is not equal to`value` using
/// the not-equal (`!=`) operator.
///
/// ## Parameters
/// - `value` (`T`): The reference value to compare against. Input must not equal
///   this value to pass validation.
/// - `isNotEqualMsg` (`String Function(String)?`): Optional custom error message generator.
///   Takes the string representation of the reference value and returns a custom error message.
///
/// ## Type Parameters
/// - `T`: The type of value being validated. Must extend `Object?` to allow for
///   null values and proper equality comparison.
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if the input is not equal to the reference value
/// - Returns an error message string if the input equals the reference value
///
/// ## Examples
/// ```dart
/// // Basic usage with strings
/// final validator = isNotEqual<String>('reserved');
/// print(validator('different')); // null (validation passes)
/// print(validator('reserved')); // "Value must not be equal to reserved"
///
/// // Custom error message
/// final customValidator = isNotEqual<int>(
///   42,
///   isNotEqualMsg: (value) => 'Please choose a number other than $value',
/// );
/// print(customValidator(42)); // "Please choose a number other than 42"
/// ```
///
/// ## Caveats
/// - The validator uses string representation for error messages, so ensure
///   your type `T` has a meaningful `toString()` implementation if using custom
///   types.
/// - Null values are handled based on Dart's null safety rules and the `!=`
///   operator's behavior with nulls.
/// {@endtemplate}
Validator<T> isNotEqual<T extends Object?>(
  T value, {
  String Function(String)? isNotEqualMsg,
}) {
  return (T input) {
    final String valueString = value.toString();
    return value != input
        ? null
        : isNotEqualMsg?.call(valueString) ??
            FormBuilderLocalizations.current.notEqualErrorText(valueString);
  };
}

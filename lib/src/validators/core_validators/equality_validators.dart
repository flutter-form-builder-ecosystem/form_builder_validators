import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_is_equal}
/// Creates a validator that checks if a given input matches `referenceValue`
/// using the equality (`==`) operator.
///
///
/// ## Parameters
/// - `referenceValue` (`T`): The value to compare against the input. This serves as
///   the reference for equality checking.
/// - `isEqualMsg` (`String Function(T input, T referenceValue)?`): Optional
/// custom error message generator. Takes the `input` and the `referenceValue`
/// as parameters and returns a custom error message.
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
/// final confirmAction = isEqual('Type this to confirm the action');
/// assert(confirmAction('Type this to confirm the action') == null); // null returned (validation passes)
/// assert(confirmAction(12345) != null); // Error message returned
///
/// // Using custom error message
/// final specificValueValidator = isEqual<int>(
///   42,
///   isEqualMsg: (_, value) => 'Value must be exactly $value',
/// );
/// ```
///
/// ## Caveats
/// - The comparison uses the `==` operator, which may not be suitable for complex
///   objects without proper equality implementation
/// - The error message uses the string representation of the value via
///   `toString()`, which might not be ideal for all types.
/// {@endtemplate}
Validator<T> isEqual<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? isEqualMsg,
}) {
  return (T input) {
    return referenceValue == input
        ? null
        : isEqualMsg?.call(input, referenceValue) ??
            FormBuilderLocalizations.current
                .equalErrorText(referenceValue.toString());
  };
}

/// {@template validator_is_not_equal}
/// Creates a validator that checks if a given input is not equal to
/// `referenceValue` using the not-equal (`!=`) operator.
///
/// ## Parameters
/// - `referenceValue` (`T`): The reference value to compare against. Input must
/// not equal this value to pass validation.
/// - `isNotEqualMsg` (`String Function(T input, T referenceValue)?`): Optional
/// custom error message generator. Takes the `input` and the `referenceValue`
/// as parameters and returns a custom error message.
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
/// assert(validator('not-reserved') == null); // null (validation passes)
/// assert(validator('reserved') != null); // "Value must not be equal to reserved"
///
/// // Custom error message
/// final customValidator = isNotEqual<int>(
///   42,
///   isNotEqualMsg: (_, value) => 'Please choose a number other than $value',
/// );
/// ```
///
/// ## Caveats
/// - The comparison uses the `!=` operator, which may not be suitable for complex
///   objects without proper equality implementation
/// - The error message uses the string representation of the value via
///   `toString()`, which might not be ideal for all types
/// {@endtemplate}
Validator<T> isNotEqual<T extends Object?>(
  T referenceValue, {
  String Function(T input, T referenceValue)? isNotEqualMsg,
}) {
  return (T input) {
    return referenceValue != input
        ? null
        : isNotEqualMsg?.call(input, referenceValue) ??
            FormBuilderLocalizations.current
                .notEqualErrorText(referenceValue.toString());
  };
}

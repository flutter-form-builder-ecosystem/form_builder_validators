import '../constants.dart';

/// {@template validator_override_error_msg}
/// Creates a new validator that replaces the error message of an existing validator
/// while preserving its validation logic.
/// This is particularly useful when you need to customize error messages for a 
/// specific validation and it is not possible by direct manipulation.
///
///
/// ## Parameters
/// - `errorMsg` (`String Function(T input)`): The new error message that will
/// replace the original validator's error message when validation fails. Takes
/// the `input` as parameter and returns a string.
/// - `v` (`Validator<T>`): The original validator whose error message will be
///   overridden. Its validation logic remains unchanged.
///
/// ## Type Parameters
/// - `T`: The type of value being validated. Extends `Object?` allowing validation
/// of nullable objects.
///
/// ## Returns
/// Returns a new `Validator<T>` function that:
/// - Returns `null` when the validation passes
/// - Returns the provided `errorMsg` when the validation fails
///
/// ## Examples
/// ```dart
/// // Original email validator
/// final emailValidator = (String value) =>
///   !value.contains('@') ? 'Invalid email format' : null;
///
/// // Creating a custom error message for a specific form
/// final customEmailValidator = overrideErrorMsg(
///   (_)=>'Please provide a valid email address',
///   emailValidator,
/// );
///
/// print(customEmailValidator('test')); // Prints: Please provide a valid email address
/// print(customEmailValidator('test@example.com')); // Prints: null
/// ```
/// {@endtemplate}
Validator<T> overrideErrorMsg<T extends Object?>(
  String Function(T input) errorMsg,
  Validator<T> v,
) {
  return (T input) {
    final String? vErrorMessage = v(input);
    if (vErrorMessage != null) {
      return errorMsg(input);
    }
    return null;
  };
}

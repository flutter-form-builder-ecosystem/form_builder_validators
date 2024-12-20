import '../constants.dart';

/// {@template validate_if}
/// Creates a conditional validator that only applies validation when a specified
/// condition is met.
///
/// The validator first evaluates the `condition` function with the input value.
/// If the condition returns true, it applies the validation rule `v`.
/// If the condition returns false, the validation automatically passes.
///
/// ## Example
/// ```dart
/// final validator = validateIf<String>(
///   (value) => value.startsWith('http'),
///   isValidUrl,
/// );
/// ```
///
/// ## Parameters
/// - `condition`: Function that determines if validation should be applied
/// - `v`: Validation function to apply when condition is true
///
/// ## Returns
/// - `null` if condition is false or validation passes
/// - Validation failure message from `v` if condition is true and validation fails
///
/// ## Type Parameters
/// - `T`: Type of value being validated, may be a nullable Object
/// {@endtemplate}
Validator<T> validateIf<T extends Object?>(
    bool Function(T value) condition, Validator<T> v) {
  return (T value) => condition(value) ? v(value) : null;
}

/// {@template skip_if}
/// Creates a validator that conditionally bypasses validation based on a
/// predicate function.
///
/// First evaluates `condition` with the input value. If true, validation is
/// skipped and automatically passes. If false, applies validation rule `v`.
///
/// ## Example
/// ```dart
/// final validator = skipIf<String>(
///   (value) => value.isEmpty,
///   validateEmail,
/// );
/// ```
///
/// ## Parameters
/// - `condition`: Predicate function determining if validation should be skipped
/// - `v`: Validation function to apply when condition is false
///
/// ## Returns
/// - `null` if condition is true or validation passes
/// - Validation failure message from `v` if condition is false and validation fails
///
/// ## Type Parameters
/// - `T`: Type of value being validated, may be a nullable Object
/// {@endtemplate}
Validator<T> skipIf<T extends Object?>(
    bool Function(T value) condition, Validator<T> v) {
  return (T value) => condition(value) ? null : v(value);
}

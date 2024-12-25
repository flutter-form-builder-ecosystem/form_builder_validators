import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_is_required}
/// Generates a validator function that enforces required field validation for
/// form inputs. This validator ensures that a field has a non-null, non-empty
/// value before any subsequent validation is performed.
///
/// ## Type Parameters
/// - `T`: Represents the non-nullable version of the field's type that will be
/// passed to any subsequent validators. Once this validator passes, downstream
/// validators are guaranteed to receive a non-null value, eliminating the need
/// for additional null checks.
///
/// ## Parameters
/// - `next` (`Validator<T>?`): An optional subsequent validator function that
///   will be applied after the required validation passes. This allows for
///   chaining multiple validation rules.
/// - `isRequiredMsg` (`String?`): An optional custom error message to display
///   when the field is empty or null. If not provided, defaults to the
///   localized required field error text.
///
/// ## Returns
/// Returns a `Validator<T?>` function that:
/// - Returns null if the value passes both required and subsequent `next`
/// validation
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic required field validation
/// final validator = isRequired<String>();
/// print(validator(null));     // Returns localized error message
/// print(validator(''));       // Returns localized error message
/// print(validator('value')); // Returns null (validation passed)
///
/// // Chaining with another validator
/// final complexValidator = isRequired<String>(
///   (value) => value.length < 10 ? 'Too long' : null,
///   'Custom required message'
/// );
/// ```
///
/// ## Caveats
/// - The validator assumes empty strings/maps/iterables, white strings, and null
/// values are equivalent for validation purposes
/// {@endtemplate}
Validator<T?> isRequired<T extends Object>([
  Validator<T>? next,
  String? isRequiredMsg,
]) {
  String? finalValidator(T? value) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(value);
    if (!isValid) {
      return isRequiredMsg ??
          FormBuilderLocalizations.current.requiredErrorText;
    }
    return next?.call(transformedValue!);
  }

  return finalValidator;
}

/// {@template validator_validate_with_default}
/// Creates a validator function that applies a default value before validation,
/// making sure the `next` validator will always receive a non-null input.
///
/// This function generates a new validator that first replaces null input
/// with a specified default value, then applies `next` validator.
///
/// ## Type Parameters
/// - `T`: The non-nullable version of the type of the input being validated.
/// It must extend from `Object`.
///
/// ## Parameters
/// - `defaultValue` (`T`): The fallback non-null value to use when input is null.
/// - `next` (`Validator<T>`): The validation function to apply after the default
///   value has been potentially substituted.
///
/// ## Returns
/// Returns a new `Validator<T?>` function that accepts nullable input and
/// produces validation results based on the combined default value substitution
/// and validation logic. The returned validator is a function that:
/// - Returns null if the value, potentially replaced with the default, passes
/// the `next` validation
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Create a validator that requires a minimum length of 3
/// final minLength = (String value) =>
///     value.length >= 3 ? null : 'Must be at least 3 characters';
///
/// // Wrap it with a default value of 'N/A'
/// final defaultValue = 'default value';
/// final validator = validateWithDefault('N/A', minLength);
///
/// print(validator(null));      // Returns null (valid)
/// print(validator('ab'));      // Returns 'Must be at least 3 characters'
/// print(validator('abc'));     // Returns null (valid)
/// // Equivalent to:
/// print(minLength(null ?? defaultValue));      // Returns null (valid)
/// print(minLength('ab' ?? defaultValue));      // Returns 'Must be at least 3 characters'
/// print(minLength('abc' ?? defaultValue));      // Returns null (valid)
/// ```
/// {@endtemplate}
Validator<T?> validateWithDefault<T extends Object>(
    T defaultValue, Validator<T> next) {
  return (T? value) => next(value ?? defaultValue);
}

/// {@template validator_is_optional}
/// Creates a validator function that makes a field optional while allowing additional validation
/// rules. This validator is particularly useful in form validation scenarios where certain
/// fields are not mandatory but still need to conform to specific rules when provided.
///
/// The validator handles various input types including strings, iterables, and maps,
/// considering them as "not provided" when they are null, empty, or contain only whitespace
/// (for strings).
///
/// ## Type Parameters
/// - `T`: Represents the non-nullable version of the field's type that will be
/// passed to any subsequent validators. Once a non-null value is passed, downstream
/// validators are guaranteed to receive a non-null value, eliminating the need
/// for additional null checks.
///
/// ## Parameters
/// - `next` (`Validator<T>?`): An optional subsequent validator function that will be
///   applied only if the input value is provided (non-null and non-empty). This allows
///   for chaining validation rules.
/// - `isOptionalMsg` (`String Function(String)?`): An optional function that transforms
///   the error message from the `next` validator. If not provided, uses a default
///   localized error message.
///
/// ## Returns
/// Returns a `Validator<T?>` function that:
/// - Returns `null` if the input is not provided (indicating valid optional field)
/// - Returns `null` if the non-null/non-empty input passes the `next` validation
/// rules.
/// - Returns a formatted error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic optional string validator
/// final validator = isOptional<String>();
///
/// // Optional validator with additional email validation
/// final emailValidator = isOptional<String>(
///   validateEmail,
///   (error) => 'Invalid email format: $error',
/// );
///
/// // Usage with different inputs
/// print(validator(null));     // Returns: null (valid)
/// print(validator(''));       // Returns: null (valid)
/// print(emailValidator('invalid@email')); // Returns: error message
/// ```
///
/// ## Caveats
/// - The validator assumes empty strings/maps/iterables, white strings, and null values are
/// equivalent for validation purposes, all them are considered valid.
/// {@endtemplate}
Validator<T?> isOptional<T extends Object>([
  Validator<T>? next,
  String Function(String)? isOptionalMsg,
]) {
  String? finalValidator(T? value) {
    final (bool isValid, T? transformedValue) =
        _isRequiredValidateAndConvert(value);
    if (!isValid) {
      // field not provided
      return null;
    }
    final String? nextErrorMessage = next?.call(transformedValue!);
    if (nextErrorMessage == null) {
      return null;
    }

    return isOptionalMsg?.call(nextErrorMessage) ??
        FormBuilderLocalizations.current.isOptionalErrorText(nextErrorMessage);
  }

  return finalValidator;
}

(bool, T?) _isRequiredValidateAndConvert<T extends Object>(T? value) {
  if (value != null &&
      (value is! String || value.trim().isNotEmpty) &&
      (value is! Iterable || value.isNotEmpty) &&
      (value is! Map || value.isNotEmpty)) {
    return (true, value);
  }
  return (false, null);
}

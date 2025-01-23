// Type validator:

import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_is_string}
/// Creates a validator that verifies if an input value is a [String]. If the
/// check succeeds, the transformed value will be passed to the `next`
/// validator.
///
/// ## Type Parameters
/// - T: The type of the input value, must extend Object to ensure non-null values
///
/// ## Parameters
/// - `next` (`Validator<String>?`): An optional subsequent validator that processes
///   the input after successful string validation. Receives the validated input
///   as a [String].
/// - `isStringMsg` (`String Function(T input)?`): An optional custom error message
///   generator function that takes the input as parameter and returns a customized error
///   message.
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns null if the input is valid and no `next` validator is provided
/// - If the input is a valid [String], returns the result of the `next` validator
/// - Returns an error message string if the input is not a [String]
///
/// ## Examples
/// ```dart
/// // Basic string validation
/// final validator = isString<Object>();
/// print(validator('valid string')); // null
/// print(validator(123)); // 'Must be a string'
///
/// // With custom error message
/// final customValidator = isString<dynamic>(
///   isStringMsg: (input) => '${input.toString()} is not a valid String.',
/// );
/// print(customValidator(42)); // '42 is not a valid string'
///
/// // Chaining validators
/// final chainedValidator = isString<Object>(
///   (value) => value.isEmpty ? 'String cannot be empty' : null,
/// );
/// print(chainedValidator('')); // 'String cannot be empty'
/// ```
///
///
/// ## Caveats
/// - This validator does not automatically convert the input to [String]. For
/// example, if the input is a number, it will never transform it to the string
/// version by calling `toString` method.
/// {@endtemplate}
Validator<T> isString<T extends Object>([
  Validator<String>? next,
  String Function(T input)? isStringMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, String? typeTransformedValue) =
        _isStringValidateAndConvert(input);
    if (!isValid) {
      return isStringMsg?.call(input) ??
          FormBuilderLocalizations.current.isStringErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, String?) _isStringValidateAndConvert<T extends Object>(T value) {
  if (value is String) {
    return (true, value);
  }
  return (false, null);
}

/// {@template validator_is_int}
/// Creates a validator that verifies if an input value is an [int] or can be
/// parsed into an [int]. If the check succeeds, the transformed value will be
/// passed to the `next` validator.
///
/// This validator performs two key checks:
/// 1. Direct validation of `int` types
/// 2. String parsing validation for string inputs that represent integers
///
/// ## Type Parameters
/// - `T`: The type of the input value. Must extend `Object` to ensure non-null
/// values.
///
/// ## Parameters
/// - `next` (`Validator<int>?`): An optional subsequent validator that receives
///   the converted integer value for additional validation
/// - `isIntMsg` (`String Function(T input)?`): Optional custom error message
///   generator function that receives the invalid input and returns an error
///   message
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if validation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if provided and initial
/// validation succeeds
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic integer validation
/// final validator = isInt();
/// print(validator(42));        // null (valid)
/// print(validator('123'));     // null (valid)
/// print(validator('abc'));     // 'This field requires a valid integer.'
///
/// // With custom error message
/// final customValidator = isInt(null, (input) => 'Custom error for: $input');
/// print(customValidator('abc')); // 'Custom error for: abc'
///
/// // With chained validation
/// final rangeValidator = isInt((value) =>
///     value > 100 ? 'Must be less than 100' : null);
/// print(rangeValidator('150')); // 'Must be less than 100'
/// ```
///
/// ## Caveats
/// - If the input is [String], it will be parsed by the [int.tryParse] method.
/// {@endtemplate}
Validator<T> isInt<T extends Object>(
    [Validator<int>? next, String Function(T input)? isIntMsg]) {
  String? finalValidator(T input) {
    final (bool isValid, int? typeTransformedValue) =
        _isIntValidateAndConvert(input);
    if (!isValid) {
      return isIntMsg?.call(input) ??
          FormBuilderLocalizations.current.integerErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, int?) _isIntValidateAndConvert<T extends Object>(T value) {
  if (value is int) {
    return (true, value);
  }
  if (value is String) {
    final int? candidateValue = int.tryParse(value);
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}

/// {@template validator_is_num}
/// Creates a validator that verifies if an input value is a [num] or can be
/// parsed into a [num]. If the check succeeds, the transformed value will be
/// passed to the `next` validator.
///
/// This validator performs two key checks:
/// 1. Direct validation of `num` types (including both `int` and `double`)
/// 2. String parsing validation for string inputs that represent numbers
///
/// ## Type Parameters
/// - `T`: The type of the input value. Must extend `Object` to ensure non-null
/// values
///
/// ## Parameters
/// - `next` (`Validator<num>?`): An optional subsequent validator that receives
///   the converted numeric value for additional validation
/// - `isNumMsg` (`String Function(T input)?`): Optional custom error message
///   generator function that receives the invalid input and returns an error
///   message
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if validation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if provided and initial
/// validation succeeds
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic number validation
/// final validator = isNum();
/// print(validator(42));        // null (valid)
/// print(validator(3.14));      // null (valid)
/// print(validator('123.45'));  // null (valid)
/// print(validator('1e-4'));    // null (valid)
/// print(validator('abc'));     // 'Please enter a valid number'
///
/// // With custom error message
/// final customValidator = isNum(null, (input) => 'Invalid number: $input');
/// print(customValidator('abc')); // 'Invalid number: abc'
///
/// // With chained validation
/// final rangeValidator = isNum((value) =>
///     value > 1000 ? 'Must be less than 1000' : null);
/// print(rangeValidator('1500')); // 'Must be less than 1000'
/// ```
///
/// ## Caveats
/// - If the input is [String], it will be parsed by the [num.tryParse] method.
/// {@endtemplate}
Validator<T> isNum<T extends Object>(
    [Validator<num>? next, String Function(T input)? isNumMsg]) {
  String? finalValidator(T input) {
    final (bool isValid, num? typeTransformedValue) =
        _isNumValidateAndConvert(input);
    if (!isValid) {
      return isNumMsg?.call(input) ??
          FormBuilderLocalizations.current.numericErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, num?) _isNumValidateAndConvert<T extends Object>(T value) {
  if (value is num) {
    return (true, value);
  }
  if (value is String) {
    final num? candidateValue = num.tryParse(value);
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}

/// {@template validator_is_double}
/// Creates a validator that verifies if an input value is a [double] or can be
/// parsed into a [double]. If the check succeeds, the transformed value will be
/// passed to the `next` validator.
///
/// This validator performs two key checks:
/// 1. Direct validation of `double` types
/// 2. String parsing validation for string inputs that represent doubles
///
/// ## Type Parameters
/// - `T`: The type of the input value. Must extend `Object` to ensure non-null
/// values
///
/// ## Parameters
/// - `next` (`Validator<double>?`): An optional subsequent validator that receives
///   the converted numeric value for additional validation
/// - `isDoubleMsg` (`String Function(T input)?`): Optional custom error message
///   generator function that receives the invalid input and returns an error
///   message
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if validation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if provided and initial
/// validation succeeds
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic number validation
/// final validator = isDouble();
/// print(validator(42.0));        // null (valid)
/// print(validator(3.14));      // null (valid)
/// print(validator('123.45'));  // null (valid)
/// print(validator('1e-4'));    // null (valid)
/// print(validator('abc'));     // 'Please enter a valid number'
///
/// // With custom error message
/// final customValidator = isDouble(null, (input) => 'Invalid number: $input');
/// print(customValidator('abc')); // 'Invalid number: abc'
///
/// // With chained validation
/// final rangeValidator = isDouble((value) =>
///     value > 1000 ? 'Must be less than 1000' : null);
/// print(rangeValidator('1500')); // 'Must be less than 1000'
/// ```
///
/// ## Caveats
/// - If the input is [String], it will be parsed by the [double.tryParse] method.
/// {@endtemplate}
Validator<T> isDouble<T extends Object>(
    [Validator<double>? next, String Function(T input)? isDoubleMsg]) {
  String? finalValidator(T input) {
    final (bool isValid, double? typeTransformedValue) =
        _isDoubleValidateAndConvert(input);
    if (!isValid) {
      // Numeric error text is enough for the final user. He does not know what
      // a double is.
      return isDoubleMsg?.call(input) ??
          FormBuilderLocalizations.current.numericErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, double?) _isDoubleValidateAndConvert<T extends Object>(T value) {
  if (value is double) {
    return (true, value);
  }
  if (value is String) {
    final double? candidateValue = double.tryParse(value);
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}

/// {@template validator_is_bool}
/// Creates a validator that verifies if an input value is a [bool] or can be
/// parsed into a [bool]. If the check succeeds, the transformed value will be
/// passed to the `next` validator.
///
/// This validator performs two key checks:
/// 1. Direct validation of `bool` types
/// 2. String parsing validation for string inputs that represent booleans
///
/// ## Type Parameters
/// - `T`: The type of the input value. Must extend `Object` to ensure non-null
/// values
///
/// ## Parameters
/// - `next` (`Validator<bool>?`): An optional subsequent validator that receives
///   the converted boolean value for additional validation
/// - `isBoolMsg` (`String Function(T input)?`): Optional custom error message
///   generator function that receives the invalid input and returns an error
///   message
/// - `caseSensitive` (`bool`): Controls whether string parsing is case-sensitive.
///   When `false`, values like 'TRUE', 'True', and 'true' are all valid. Defaults
///   to `false`
/// - `trim` (`bool`): Controls whether to remove whitespace before parsing string
///   inputs. When `true`, strings like ' true ' and 'false\n' are valid. Defaults
///   to `true`
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if validation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if provided and initial
/// validation succeeds
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic boolean validation
/// final validator = isBool();
/// print(validator(true));       // null (valid)
/// print(validator('true'));     // null (valid)
/// print(validator('TRUE'));     // null (valid)
/// print(validator(' false '));  // null (valid)
/// print(validator('abc'));      // 'This field requires a valid boolean (true or false).'
///
/// // With case sensitivity
/// final strictValidator = isBool(null, null, true);
/// print(strictValidator('True')); // 'This field requires a valid boolean (true or false).'
/// print(strictValidator('true')); // null (valid)
///
/// // Without trimming
/// final noTrimValidator = isBool(null, null, false, false);
/// print(noTrimValidator(' true')); // 'This field requires a valid boolean (true or false).'
///
/// // With custom error message
/// final customValidator = isBool(null, (input) => 'Invalid boolean: $input');
/// print(customValidator('abc')); // 'Invalid boolean: abc'
///
/// // With chained validation
/// final customValidator = isBool((value) =>
///     value == true ? 'Must be false' : null);
/// print(customValidator('true')); // 'Must be false'
/// ```
///
/// ## Caveats
/// - If the input is [String], it will be parsed by the [bool.tryParse] method
/// {@endtemplate}
Validator<T> isBool<T extends Object>(
    [Validator<bool>? next,
    String Function(T input)? isBoolMsg,
    bool caseSensitive = false,
    bool trim = true]) {
  String? finalValidator(T input) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(input,
            caseSensitive: caseSensitive, trim: trim);
    if (!isValid) {
      return isBoolMsg?.call(input) ??
          FormBuilderLocalizations.current.booleanErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, bool?) _isBoolValidateAndConvert<T extends Object>(T value,
    {bool caseSensitive = false, bool trim = true}) {
  if (value is bool) {
    return (true, value);
  }
  if (value is String) {
    final bool? candidateValue = bool.tryParse(trim ? value.trim() : value,
        caseSensitive: caseSensitive);
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}

/// {@template validator_is_date_time}
/// Creates a validator that verifies if an input value is a [DateTime] or can be
/// parsed into a [DateTime]. If the check succeeds, the transformed value will be
/// passed to the `next` validator.
///
/// This validator performs two key checks:
/// 1. Direct validation of `DateTime` types
/// 2. String parsing validation for string inputs that represent dates
///
/// ## Type Parameters
/// - `T`: The type of the input value. Must extend `Object` to ensure non-null
/// values
///
/// ## Parameters
/// - `next` (`Validator<DateTime>?`): An optional subsequent validator that
///   receives the converted datetime value for additional validation
/// - `isDateTimeMsg` (`String Function(T input)?`): Optional custom error message
///   generator function that receives the invalid input and returns an error
///   message
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if validation succeeds and no `next` validator is provided
/// - Returns the result of the `next` validator if provided and initial
/// validation succeeds
/// - Returns an error message string if validation fails
///
/// ## Examples
/// ```dart
/// // Basic datetime validation
/// final validator = isDateTime();
/// print(validator(DateTime.now()));          // null (valid)
/// print(validator('2024-12-31'));           // null (valid)
/// print(validator('2024-12-31T23:59:59'));  // null (valid)
/// print(validator('not a date'));           // 'This field requires a valid datetime.'
///
/// // With custom error message
/// final customValidator = isDateTime(
///   null,
///   (input) => 'Invalid date format: $input'
/// );
/// print(customValidator('abc')); // 'Invalid date format: abc'
///
/// // With chained validation
/// final futureValidator = isDateTime((value) =>
///     value.isBefore(DateTime.now()) ? 'Date must be in the future' : null);
/// print(futureValidator('2020-01-01')); // 'Date must be in the future'
/// ```
///
/// ## Caveats
/// - If the input is [String], it will be parsed by the [DateTime.tryParse] method.
/// - The function parses a subset of ISO 8601, which includes the subset
/// accepted by RFC 3339.
/// {@endtemplate}
Validator<T> isDateTime<T extends Object>([
  Validator<DateTime>? next,
  String Function(T input)? isDateTimeMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, DateTime? typeTransformedValue) =
        _isDateTimeValidateAndConvert(input);
    if (!isValid) {
      return isDateTimeMsg?.call(input) ??
          FormBuilderLocalizations.current.dateTimeErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, DateTime?) _isDateTimeValidateAndConvert<T extends Object>(T value) {
  if (value is DateTime) {
    return (true, value);
  }

  if (value is String) {
    final DateTime? transformedValue = DateTime.tryParse(value);
    if (transformedValue != null) {
      return (true, transformedValue);
    }
  }
  return (false, null);
}

// TODO add other types like: Uri, isT(which checks if input is T and tries to
//  apply the parsing strategy from the user. It is close to transformAndValidate,
//  but not altogether) etc. Is collection (if an use case is found)

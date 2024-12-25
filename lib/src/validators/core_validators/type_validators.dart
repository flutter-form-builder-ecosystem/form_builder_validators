// Type validator:

import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@template validator_is_string}
/// Creates a validator function that checks if the provided non-nullable input
/// is a String. If it is a valid string, it will be passed to the `next` validator.
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

/// This function returns a validator that checks if the user input is either an
/// `int` or a `String` that is parsable to an `int`.
/// If it checks positive, then it returns null when `next` is not provided. Otherwise,
/// if `next` is provided, it passes the transformed value as `int` to the `next`
/// validator.
Validator<T> isInt<T extends Object>([Validator<int>? next, String? isIntMsg]) {
  String? finalValidator(T value) {
    final (bool isValid, int? typeTransformedValue) =
        _isIntValidateAndConvert(value);
    if (!isValid) {
      return isIntMsg ?? FormBuilderLocalizations.current.integerErrorText;
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

/// This function returns a validator that checks if the user input is either a
/// `num` or a `String` that is parsable to a `num`.
/// If it checks positive, then it returns null when `next` is not provided. Otherwise,
/// if `next` is provided, it passes the transformed value as `num` to the `next`
/// validator.
Validator<T> isNum<T extends Object>([Validator<num>? next, String? isNumMsg]) {
  String? finalValidator(T value) {
    final (bool isValid, num? typeTransformedValue) =
        _isNumValidateAndConvert(value);
    if (!isValid) {
      return isNumMsg ?? FormBuilderLocalizations.current.numericErrorText;
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

const tmpIsBoolMsg = 'Value must be "true" or "false"';

/// This function returns a validator that checks if the user input is either a
/// `bool` or a `String` that is parsable to a `bool`.
/// If it checks positive, then it returns null when `next` is not provided. Otherwise,
/// if `next` is provided, it passes the transformed value as `bool` to the `next`
/// validator.
///
/// ## Parameters
/// For the following parameters, consider the information that the parsing process
/// only happens if the input is a `String`.
/// - `caseSensitive` (defaults to `false`): whether the parsing process is case
/// sensitive. If true, inputs like `FaLsE` would be accepted as a valid boolean.
/// - `trim` (defaults to `true`): whether the parsing process is preceded by a
/// trim of whitespaces (`\n`, `\t`, `' '`, etc). If true, inputs like `false \n` would
/// be accepted as valid `bool`.
Validator<T> isBool<T extends Object>(
    [Validator<bool>? next,
    String? isBoolMsg,
    bool caseSensitive = false,
    bool trim = true]) {
  String? finalValidator(T value) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(value,
            caseSensitive: caseSensitive, trim: trim);
    if (!isValid) {
      // TODO(ArturAssisComp): Add the default error message for the isBool validator.
      return isBoolMsg ??
          tmpIsBoolMsg; //FormBuilderLocalizations.current.boolErrorText;
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

/// This function returns a validator that checks if the user input is either a `DateTime`
/// or a parsable String to `DateTime`.
/// If it checks positive, then it returns null when `next` is not provided.
/// Otherwise, if `next` is provided, it passes the transformed value as `String`
/// to the `next` validator.
///
/// ## Caveats
/// - If the user input is a String, the validator tries to parse it using the
/// [DateTime.tryParse] method (which parses a subset of ISO 8601 date specifications),
/// thus, it cannot be adapted to parse only some specific DateTime pattern.
Validator<T> isDateTime<T extends Object>([
  Validator<DateTime>? next,
  String? isDateTimeMsg,
]) {
  String? finalValidator(T value) {
    final (bool isValid, DateTime? typeTransformedValue) =
        _isDateTimeValidateAndConvert(value);
    if (!isValid) {
      return isDateTimeMsg ??
          // This error text is not 100% correct for this validator. It also validates non-Strings.
          FormBuilderLocalizations.current.dateStringErrorText;
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

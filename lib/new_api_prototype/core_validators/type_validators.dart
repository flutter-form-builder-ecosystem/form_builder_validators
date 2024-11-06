// Type validator:

import '../../localization/l10n.dart';
import '../constants.dart';

const tmpIsStringMsg = 'This field requires a valid string.';

/// This function returns a validator that checks if the user input is a `String`.
/// If it is a `String`, then it returns null when `next` is not provided. Otherwise,
/// if `next` is provided, it passes the transformed value as `String` to the `next`
/// validator.
Validator<T> isString<T extends Object>([
  Validator<String>? next,
  String? isStringMsg,
]) {
  String? finalValidator(T value) {
    final (bool isValid, String? typeTransformedValue) =
        _isStringValidateAndConvert(value);
    if (!isValid) {
      return isStringMsg ?? tmpIsStringMsg;
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

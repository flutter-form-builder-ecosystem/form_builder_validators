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

Validator<T> isInt<T extends Object>(Validator<int>? v, {String? isIntMsg}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isIntValidateAndConvert(value);
    if (!isValid) {
      return isIntMsg ?? FormBuilderLocalizations.current.integerErrorText;
    }
    return v?.call(typeTransformedValue!);
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

Validator<T> isNum<T extends Object>(Validator<num>? v, {String? isNumMsg}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isNumValidateAndConvert(value);
    if (!isValid) {
      return isNumMsg ?? FormBuilderLocalizations.current.numericErrorText;
    }
    return v?.call(typeTransformedValue!);
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

Validator<T> isBool<T extends Object>(Validator<bool>? v,
    {String? isBoolMsg, bool caseSensitive = false, bool trim = true}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isBoolValidateAndConvert(value,
        caseSensitive: caseSensitive, trim: trim);
    if (!isValid) {
      // TODO(ArturAssisComp): Add the default error message for the isBool validator.
      return isBoolMsg ??
          'default bool error msg'; //FormBuilderLocalizations.current.boolErrorText;
    }
    return v?.call(typeTransformedValue!);
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

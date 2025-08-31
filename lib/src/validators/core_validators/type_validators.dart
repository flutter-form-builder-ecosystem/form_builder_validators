// Type validator:

import '../../../localization/l10n.dart';
import '../constants.dart';

/// {@macro validator_string}
Validator<T> string<T extends Object>([
  Validator<String>? next,
  String Function(T input)? stringMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, String? typeTransformedValue) =
        _isStringValidateAndConvert(input);
    if (!isValid) {
      return stringMsg?.call(input) ??
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

/// {@macro validator_int}
Validator<T> isInt<T extends Object>([
  Validator<int>? next,
  String Function(T input)? isIntMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, int? typeTransformedValue) = _isIntValidateAndConvert(
      input,
    );
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

/// {@macro validator_num}
Validator<T> isNum<T extends Object>([
  Validator<num>? next,
  String Function(T input)? isNumMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, num? typeTransformedValue) = _isNumValidateAndConvert(
      input,
    );
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

/// {@macro validator_double}
Validator<T> isDouble<T extends Object>([
  Validator<double>? next,
  String Function(T input)? isDoubleMsg,
]) {
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

/// {@macro validator_bool}
Validator<T> isBool<T extends Object>([
  Validator<bool>? next,
  String Function(T input)? isBoolMsg,
  bool caseSensitive = false,
  bool trim = true,
]) {
  String? finalValidator(T input) {
    final (
      bool isValid,
      bool? typeTransformedValue,
    ) = _isBoolValidateAndConvert(
      input,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (!isValid) {
      return isBoolMsg?.call(input) ??
          FormBuilderLocalizations.current.booleanErrorText;
    }
    return next?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, bool?) _isBoolValidateAndConvert<T extends Object>(
  T value, {
  bool caseSensitive = false,
  bool trim = true,
}) {
  if (value is bool) {
    return (true, value);
  }
  if (value is String) {
    final bool? candidateValue = bool.tryParse(
      trim ? value.trim() : value,
      caseSensitive: caseSensitive,
    );
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}

/// {@macro validator_date_time}
Validator<T> dateTime<T extends Object>([
  Validator<DateTime>? next,
  String Function(T input)? dateTimeMsg,
]) {
  String? finalValidator(T input) {
    final (bool isValid, DateTime? typeTransformedValue) =
        _isDateTimeValidateAndConvert(input);
    if (!isValid) {
      return dateTimeMsg?.call(input) ??
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

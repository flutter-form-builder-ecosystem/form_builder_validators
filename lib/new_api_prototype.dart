// ignore_for_file: always_specify_types, prefer_const_constructors, public_member_api_docs

import 'localization/l10n.dart';

typedef Validator<T extends Object?> = String? Function(T);

// Emptiness check validator:
Validator<T?> isRequired<T extends Object>(
  Validator<T>? v, {
  String? isRequiredMsg,
}) {
  String? finalValidator(T? value) {
    final (isValid, transformedValue) = _isRequiredValidateAndConvert(value);
    if (!isValid) {
      return isRequiredMsg ??
          FormBuilderLocalizations.current.requiredErrorText;
    }
    return v?.call(transformedValue!);
  }

  return finalValidator;
}

Validator<T?> isOptional<T extends Object>(
  Validator<T>? v, {
  String? isOptionalMsg,
}) {
  String? finalValidator(T? value) {
    final (isValid, transformedValue) = _isRequiredValidateAndConvert(value);
    if (!isValid) {
      // field not provided
      return null;
    }
    final vErrorMessage = v?.call(transformedValue!);
    if (vErrorMessage == null) {
      return null;
    }

    return 'The field is optional, otherwise, $vErrorMessage';
  }

  return finalValidator;
}

const isReq = isRequired;
const isOpt = isOptional;

(bool, T?) _isRequiredValidateAndConvert<T extends Object>(T? value) {
  if (value != null &&
      (value is! String || value.trim().isNotEmpty) &&
      (value is! Iterable || value.isNotEmpty) &&
      (value is! Map || value.isNotEmpty)) {
    return (true, value);
  }
  return (false, null);
}

// Type validator:

Validator<T> isString<T extends Object>(Validator<String>? v,
    {String? isStringMsg}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isStringValidateAndConvert(value);
    if (!isValid) {
      return isStringMsg ?? 'This field requires a valid string.';
    }
    return v?.call(typeTransformedValue!);
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

// Composition validators
Validator<T> and<T extends Object>(
  List<Validator<T>> validators, {
  bool printErrorAsSoonAsPossible = true,
}) {
  return (T value) {
    final errorMessageBuilder = <String>[];
    for (final validator in validators) {
      final errorMessage = validator(value);
      if (errorMessage != null) {
        if (printErrorAsSoonAsPossible) {
          return errorMessage;
        }
        errorMessageBuilder.add(errorMessage);
      }
    }
    if (errorMessageBuilder.isNotEmpty) {
      return errorMessageBuilder.join(' AND ');
    }

    return null;
  };
}

Validator<T> or<T extends Object>(List<Validator<T>> validators) {
  return (T value) {
    final errorMessageBuilder = <String>[];
    for (final validator in validators) {
      final errorMessage = validator(value);
      if (errorMessage == null) {
        return null;
      }
      errorMessageBuilder.add(errorMessage);
    }
    return errorMessageBuilder.join(' OR ');
  };
}

// String validators

const _minL = minLength;
const _maxL = maxLength;
Validator<String> password({
  int minLength = 8,
  int maxLength = 32,
  int minUppercaseCount = 1,
  int minLowercaseCount = 1,
  int minNumberCount = 1,
  int minSpecialCharCount = 1,
  String? passwordMsg,
}) {
  final andValidator = and([
    _minL(minLength),
    _maxL(maxLength),
    hasMinUppercaseChars(min: minUppercaseCount),
    hasMinLowercaseChars(min: minLowercaseCount),
    hasMinNumericChars(min: minNumberCount),
    hasMinSpecialChars(min: minSpecialCharCount),
  ]);
  return passwordMsg != null
      ? overrideErrorMsg(passwordMsg, andValidator)
      : andValidator;
}

final _numericRegex = RegExp('[0-9]');
final _specialRegex = RegExp('[^A-Za-z0-9]');

({int upperCount, int lowerCount}) _upperAndLowerCaseCounter(String value) {
  var uppercaseCount = 0;
  var lowercaseCount = 0;
  final upperCaseVersion = value.toUpperCase();
  final lowerCaseVersion = value.toLowerCase();
  // initial version: 1.0
  final o = value.runes.iterator;
  final u = upperCaseVersion.runes.iterator;
  final l = lowerCaseVersion.runes.iterator;
  while (o.moveNext() && u.moveNext() && l.moveNext()) {
    if (o.current == u.current && o.current != l.current) {
      uppercaseCount++;
    } else if (o.current != u.current && o.current == l.current) {
      lowercaseCount++;
    }
  }
  return (lowerCount: lowercaseCount, upperCount: uppercaseCount);
}

/// Returns a [Validator] function that checks if its [String] input has at
/// least [min] uppercase chars. If the input satisfies this condition, the
/// validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.containsUppercaseCharErrorText(min)`, if
/// [hasMinUppercaseCharsMsg] is not provided.
///
/// # Caveats
/// - The only uppercase chars that are counted are those that are affected by
/// String methods toLowerCase/toUpperCase and are in the uppercase state.
/// - By default, the validator returned counts the uppercase chars using a
/// language independent unicode mapping, which may not work for some languages.
/// For that situations, the user can provide a custom uppercase counter
/// function.
///
/// # Errors
/// - Throws an [AssertionError] if [min] is not positive (< 1).
Validator<String> hasMinUppercaseChars({
  int min = 1,
  int Function(String)? customUppercaseCounter,
  String Function(int)? hasMinUppercaseCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (value) {
    var uppercaseCount = customUppercaseCounter?.call(value) ??
        _upperAndLowerCaseCounter(value).upperCount;

    return uppercaseCount >= min
        ? null
        : hasMinUppercaseCharsMsg?.call(min) ??
            FormBuilderLocalizations.current
                .containsUppercaseCharErrorText(min);
  };
}

/// Returns a [Validator] function that checks if its [String] input has at
/// least [min] lowercase chars. If the input satisfies this condition, the
/// validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.containsUppercaseCharErrorText(min)`, if
/// [hasMinLowercaseCharsMsg] is not provided.
///
/// # Caveats
/// - The only lowercase chars that are counted are those that are affected by
/// String methods toLowerCase/toUpperCase and are in the lowercase state.
/// - By default, the validator returned counts the lowercase chars using a
/// language independent unicode mapping, which may not work for some languages.
/// For that situations, the user can provide a custom lowercase counter
/// function.
///
/// # Errors
/// - Throws an [AssertionError] if [min] is not positive (< 1).
Validator<String> hasMinLowercaseChars({
  int min = 1,
  int Function(String)? customLowercaseCounter,
  String Function(int)? hasMinLowercaseCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (value) {
    var lowercaseCount = customLowercaseCounter?.call(value) ??
        _upperAndLowerCaseCounter(value).lowerCount;

    return lowercaseCount >= min
        ? null
        : hasMinLowercaseCharsMsg?.call(min) ??
            FormBuilderLocalizations.current
                .containsLowercaseCharErrorText(min);
  };
}

/// Returns a [Validator] function that checks if its [String] input has at
/// least [min] numeric chars (0-9). If the input satisfies this condition, the
/// validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.containsNumberErrorText(min)`, if
/// [hasMinNumericCharsMsg] is not provided.
///
///
/// # Caveats
/// - By default, the validator returned counts the numeric chars using the 0-9
/// regexp rule, which may not work for some languages. For that situations, the
/// user can provide a custom numeric counter function.
///
/// ```dart
/// // countNumericDigits can be a function from some specific package.
/// final validator = hasMinNumericChars(customNumericCounter:countNumericDigits);
/// ```
///
/// # Errors
/// - Throws an [AssertionError] if [min] is not positive (< 1).
Validator<String> hasMinNumericChars({
  int min = 1,
  int Function(String)? customNumericCounter,
  String Function(int)? hasMinNumericCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (value) {
    final numericCount = customNumericCounter?.call(value) ??
        _numericRegex.allMatches(value).length;
    return numericCount >= min
        ? null
        : hasMinNumericCharsMsg?.call(min) ??
            FormBuilderLocalizations.current.containsNumberErrorText(min);
  };
}

/// Returns a [Validator] function that checks if its [String] input has at
/// least [min] special chars. If the input satisfies this condition, the
/// validator returns `null`. Otherwise, it returns the default error message
/// `FormBuilderLocalizations.current.containsSpecialCharErrorText(min)`, if
/// [hasMinSpecialCharsMsg] is not provided.
///
/// # Errors
/// - Throws an [AssertionError] if [min] is not positive (< 1).
Validator<String> hasMinSpecialChars({
  int min = 1,
  RegExp? regex,
  String Function(int)? hasMinSpecialCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (value) {
    return (regex ?? _specialRegex).allMatches(value).length >= min
        ? null
        : hasMinSpecialCharsMsg?.call(min) ??
            FormBuilderLocalizations.current.containsSpecialCharErrorText(min);
  };
}

Validator<String> match(
  RegExp regex, {
  String? matchMsg,
}) {
  return (value) {
    return regex.hasMatch(value)
        ? null
        : matchMsg ?? FormBuilderLocalizations.current.matchErrorText;
  };
}

final _uuidRegex = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);
Validator<String> uuid({
  RegExp? regex,
  String? uuidMsg,
}) {
  return (value) {
    return (regex ?? _uuidRegex).hasMatch(value)
        ? null
        : uuidMsg ?? FormBuilderLocalizations.current.uuidErrorText;
  };
}

final _creditCardRegex = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);
Validator<String> creditCard({
  RegExp? regex,
  String? creditCardMsg,
}) {
  return (value) {
    return _isCreditCard(value, regex ?? _creditCardRegex)
        ? null
        : creditCardMsg ?? FormBuilderLocalizations.current.creditCardErrorText;
  };
}

final _phoneNumberRegex = RegExp(
  r'^\+?(\d{1,4}[\s.-]?)?(\(?\d{1,4}\)?[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,9})$',
);
Validator<String> phoneNumber({
  RegExp? regex,
  String? phoneNumberMsg,
}) {
  return (value) {
    final String phoneNumber = value.replaceAll(' ', '').replaceAll('-', '');
    return (regex ?? _phoneNumberRegex).hasMatch(phoneNumber)
        ? null
        : phoneNumberMsg ?? FormBuilderLocalizations.current.phoneErrorText;
  };
}

Validator<String> contains(
  String substring, {
  bool caseSensitive = true,
  String Function(String)? containsMsg,
}) {
  return (value) {
    if (substring.isEmpty) {
      return null;
    } else if (caseSensitive
        ? value.contains(substring)
        : value.toLowerCase().contains(substring.toLowerCase())) {
      return null;
    }
    return containsMsg?.call(substring) ??
        FormBuilderLocalizations.current.containsErrorText(substring);
  };
}

Validator<String> email({
  RegExp? regex,
  String? emailMsg,
}) {
  final defaultRegex = RegExp(
    r"^((([a-z]|\d|[!#$%&'*+\-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#$%&'*+\-/=?^_`{|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)(((([\x20\x09])*(\x0d\x0a))?([\x20\x09])+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*((([\x20\x09])*(\x0d\x0a))?([\x20\x09])+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
  );
  return (value) {
    return (regex ?? defaultRegex).hasMatch(value.toLowerCase())
        ? null
        : emailMsg ?? FormBuilderLocalizations.current.emailErrorText;
  };
}

Validator<String> url({
  List<String>? protocols,
  bool requireTld = true,
  bool requireProtocol = false,
  bool allowUnderscore = false,
  List<String>? hostWhitelist,
  List<String>? hostBlacklist,
  RegExp? regex,
  String? urlMsg,
}) {
  const defaultProtocols = <String>['http', 'https', 'ftp'];
  return (value) {
    return (regex != null && !regex.hasMatch(value)) ||
            !_isURL(
              value,
              protocols: protocols ?? defaultProtocols,
              requireTld: requireTld,
              requireProtocol: requireProtocol,
              allowUnderscore: allowUnderscore,
              hostWhitelist: hostWhitelist ?? [],
              hostBlacklist: hostBlacklist ?? [],
            )
        ? urlMsg ?? FormBuilderLocalizations.current.urlErrorText
        : null;
  };
}

Validator<String> ip({
  int version = 4,
  RegExp? regex,
  String? ipMsg,
}) {
  return (value) {
    return !_isIP(value, version, regex)
        ? ipMsg ?? FormBuilderLocalizations.current.ipErrorText
        : null;
  };
}

// T validators
Validator<T> isEqual<T extends Object?>(T value,
    {String Function(String)? equalMsg}) {
  return (input) {
    final valueString = value.toString();
    return value == input
        ? null
        : equalMsg?.call(valueString) ??
            FormBuilderLocalizations.current.equalErrorText(valueString);
  };
}

Validator<T> minLength<T extends Object>(int minLength,
    {String Function(int)? minLengthMsg}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength < minLength
        ? minLengthMsg?.call(minLength) ??
            FormBuilderLocalizations.current.minLengthErrorText(minLength)
        : null;
  };
}

Validator<T> maxLength<T extends Object>(int maxLength,
    {String Function(int)? maxLengthMsg}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength > maxLength
        ? maxLengthMsg?.call(maxLength) ??
            FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
        : null;
  };
}

// Numeric validators
Validator<T> max<T extends num>(T? max,
    {T Function()? dynMax,
    bool inclusive = true,
    String Function(num)? maxMsg}) {
  assert(
    max != null && dynMax == null || max == null && dynMax != null,
    'Exactly one of the inputs must be null',
  );

  return (value) {
    late final T actualMax;
    if (max != null) {
      actualMax = max;
    } else if (dynMax != null) {
      actualMax = dynMax();
    }

    return (inclusive ? (value <= actualMax) : (value < actualMax))
        ? null
        : maxMsg?.call(actualMax) ??
            FormBuilderLocalizations.current.maxErrorText(actualMax);
  };
}

Validator<T> min<T extends num>(T? min,
    {T Function()? dynMin,
    bool inclusive = true,
    String Function(num)? minMsg}) {
  assert(
    min != null && dynMin == null || min == null && dynMin != null,
    'Exactly one of the inputs must be null',
  );

  return (value) {
    late final T actualMin;
    if (min != null) {
      actualMin = min;
    } else if (dynMin != null) {
      actualMin = dynMin();
    }

    return (inclusive ? (value >= actualMin) : (value > actualMin))
        ? null
        : minMsg?.call(actualMin) ??
            FormBuilderLocalizations.current.minErrorText(actualMin);
  };
}

Validator<T> greaterThan<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? greaterThanMsg]) {
  assert(
    n != null && dynN == null || n == null && dynN != null,
    'Exactly one of the inputs must be null',
  );
  return (value) {
    final T actualN;
    if (n != null) {
      actualN = n;
    } else if (dynN != null) {
      actualN = dynN();
    } else {
      throw TypeError();
    }
    return value > actualN
        ? null
        : greaterThanMsg?.call(actualN) ??
            'Value must be greater than $actualN';
  };
}

Validator<T> greaterThanOrEqual<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? greaterThanOrEqualMsg]) {
  assert(
    n != null && dynN == null || n == null && dynN != null,
    'Exactly one of the inputs must be null',
  );
  return (value) {
    final T actualN;
    if (n != null) {
      actualN = n;
    } else if (dynN != null) {
      actualN = dynN();
    } else {
      throw TypeError();
    }
    return value >= actualN
        ? null
        : greaterThanOrEqualMsg?.call(actualN) ??
            'Value must be greater than or equal to $actualN';
  };
}

Validator<T> lessThan<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? lessThanMsg]) {
  assert(
    n != null && dynN == null || n == null && dynN != null,
    'Exactly one of the inputs must be null',
  );
  return (value) {
    final T actualN;
    if (n != null) {
      actualN = n;
    } else if (dynN != null) {
      actualN = dynN();
    } else {
      throw TypeError();
    }
    return value < actualN
        ? null
        : lessThanMsg?.call(actualN) ?? 'Value must be less than $actualN';
  };
}

Validator<T> lessThanOrEqual<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? lessThanOrEqualMsg]) {
  assert(
    n != null && dynN == null || n == null && dynN != null,
    'Exactly one of the inputs must be null',
  );
  return (value) {
    final T actualN;
    if (n != null) {
      actualN = n;
    } else if (dynN != null) {
      actualN = dynN();
    } else {
      throw TypeError();
    }
    return value <= actualN
        ? null
        : lessThanOrEqualMsg?.call(actualN) ??
            'Value must be less than or equal to $actualN';
  };
}

Validator<T> between<T extends num>(T? min, T? max,
    {T Function()? dynMin,
    T Function()? dynMax,
    bool leftInclusive = true,
    bool rightInclusive = true,
    String Function(num min, num max)? betweenMsg}) {
  assert(
    min != null && dynMin == null || min == null && dynMin != null,
    'Exactly one of the min inputs must be null',
  );
  assert(
    max != null && dynMax == null || max == null && dynMax != null,
    'Exactly one of the max inputs must be null',
  );
  return (value) {
    final T actualMin;
    final T actualMax;
    if (min != null) {
      actualMin = min;
    } else if (dynMin != null) {
      actualMin = dynMin();
    } else {
      throw TypeError();
    }
    if (max != null) {
      actualMax = max;
    } else if (dynMax != null) {
      actualMax = dynMax();
    } else {
      throw TypeError();
    }
    return (leftInclusive ? value >= actualMin : value > actualMin) &&
            (rightInclusive ? value <= actualMax : value < actualMax)
        ? null
        : betweenMsg?.call(actualMin, actualMax) ??
            'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$actualMin and less than ${rightInclusive ? 'or equal to ' : ''}$actualMax';
  };
}

const greaterT = greaterThan;
const greaterTE = greaterThanOrEqual;
const lessT = lessThan;
const lessTE = lessThanOrEqual;

// bool validators
/// Returns a [Validator] function that checks if its `T` input is a `true`
/// boolean or a [String] parsable to a `true` boolean. If the input satisfies
/// this condition, the validator returns `null`. Otherwise, it returns the
/// default error message
/// `FormBuilderLocalizations.current.mustBeTrueErrorText`, if [isTrueMsg]
/// is not provided.
///
/// # Parsing rules
/// If the input of the validator is a [String], it will be parsed using
/// the rules specified by the combination of [caseSensitive] and [trim].
/// [caseSensitive] indicates whether the lowercase must be considered equal to
/// uppercase or not, and [trim] indicates whether whitespaces from both sides
/// of the string will be ignored or not.
///
/// The default behavior is to ignore leading and trailing whitespaces and be
/// case insensitive.
///
/// # Examples
/// ```dart
/// // The following examples must pass:
/// assert(isTrue()(' true ') == null);
/// assert(isTrue(trim:false)(' true ') != null);
/// assert(isTrue()('TRue') == null);
/// assert(isTrue(caseSensitive:true)('TRue') != null);
/// ```
Validator<T> isTrue<T extends Object>(
    {String? isTrueMsg, bool caseSensitive = false, bool trim = true}) {
  return (value) {
    final (isValid, typeTransformedValue) = _isBoolValidateAndConvert(
      value,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == true) {
      return null;
    }
    return isTrueMsg ?? FormBuilderLocalizations.current.mustBeTrueErrorText;
  };
}

/// Returns a [Validator] function that checks if its `T` input is a `false`
/// boolean or a [String] parsable to a `false` boolean. If the input satisfies
/// this condition, the validator returns `null`. Otherwise, it returns the
/// default error message
/// `FormBuilderLocalizations.current.mustBeFalseErrorText`, if [isFalseMsg]
/// is not provided.
///
/// # Parsing rules
/// If the input of the validator is a [String], it will be parsed using
/// the rules specified by the combination of [caseSensitive] and [trim].
/// [caseSensitive] indicates whether the lowercase must be considered equal to
/// uppercase or not, and [trim] indicates whether whitespaces from both sides
/// of the string will be ignored or not.
///
/// The default behavior is to ignore leading and trailing whitespaces and be
/// case insensitive.
///
/// # Examples
/// ```dart
/// // The following examples must pass:
/// assert(isFalse()(' false ') == null);
/// assert(isFalse(trim:false)(' false ') != null);
/// assert(isFalse()('FAlse') == null);
/// assert(isFalse(caseSensitive:true)('FAlse') != null);
/// ```
Validator<T> isFalse<T extends Object>(
    {String? isFalseMsg, bool caseSensitive = false, bool trim = true}) {
  return (value) {
    final (isValid, typeTransformedValue) = _isBoolValidateAndConvert(
      value,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == false) {
      return null;
    }
    return isFalseMsg ?? FormBuilderLocalizations.current.mustBeFalseErrorText;
  };
}

// msg wrapper
/// Replaces any inner message with [errorMsg]. It is useful for changing
/// the message of direct validator implementations.
Validator<T> overrideErrorMsg<T extends Object?>(
  String errorMsg,
  Validator<T> v,
) {
  return (value) {
    final vErrorMessage = v(value);
    if (vErrorMessage != null) {
      return errorMsg;
    }
    return null;
  };
}

//******************************************************************************
//*                              Aux functions                                 *
//******************************************************************************
const int _maxUrlLength = 2083;
final RegExp _ipv4Maybe =
    RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final RegExp _ipv6 = RegExp(
  r'^((?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?::[0-9a-fA-F]{1,4}){1,6}|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]+|::(ffff(?::0{1,4})?:)?(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$',
);

/// Check if the string [str] is IP [version] 4 or 6.
///
/// * [version] is a String or an `int`.
bool _isIP(String? str, int version, RegExp? regex) {
  if (version != 4 && version != 6) {
    return _isIP(str, 4, regex) || _isIP(str, 6, regex);
  } else if (version == 4) {
    if (regex != null) {
      return regex.hasMatch(str!);
    } else if (!_ipv4Maybe.hasMatch(str!)) {
      return false;
    }
    final List<String> parts = str.split('.')
      ..sort((String a, String b) => int.parse(a) - int.parse(b));
    return int.parse(parts[3]) <= 255;
  } else if (regex != null) {
    return regex.hasMatch(str!);
  }
  return version == 6 && _ipv6.hasMatch(str!);
}

/// Check if the string [value] is a URL.
///
/// * [protocols] sets the list of allowed protocols
/// * [requireTld] sets if TLD is required
/// * [requireProtocol] is a `bool` that sets if protocol is required for validation
/// * [allowUnderscore] sets if underscores are allowed
/// * [hostWhitelist] sets the list of allowed hosts
/// * [hostBlacklist] sets the list of disallowed hosts
bool _isURL(
  String? value, {
  List<String?> protocols = const <String?>['http', 'https', 'ftp'],
  bool requireTld = true,
  bool requireProtocol = false,
  bool allowUnderscore = false,
  List<String> hostWhitelist = const <String>[],
  List<String> hostBlacklist = const <String>[],
  RegExp? regexp,
}) {
  if (value == null ||
      value.isEmpty ||
      value.length > _maxUrlLength ||
      value.startsWith('mailto:')) {
    return false;
  }
  final int port;
  final String? protocol;
  final String? auth;
  final String user;
  final String host;
  final String hostname;
  final String portStr;
  final String path;
  final String query;
  final String hash;

  // check protocol
  List<String> split = value.split('://');
  if (split.length > 1) {
    protocol = _shift(split).toLowerCase();
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol == true) {
    return false;
  }
  final String str1 = split.join('://');

  // check hash
  split = str1.split('#');
  final String str2 = _shift(split);
  hash = split.join('#');
  if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str2.split('?');
  final String str3 = _shift(split);
  query = split.join('?');
  if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str3.split('/');
  final String str4 = _shift(split);
  path = split.join('/');
  if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str4.split('@');
  if (split.length > 1) {
    auth = _shift(split);
    if (auth?.contains(':') ?? false) {
      user = _shift(auth!.split(':'));
      if (!RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      if (!RegExp(r'^\S*$').hasMatch(user)) {
        return false;
      }
    }
  }

  // check hostname
  hostname = split.join('@');
  split = hostname.split(':');
  host = _shift(split).toLowerCase();
  if (split.isNotEmpty) {
    portStr = split.join(':');
    try {
      port = int.parse(portStr, radix: 10);
    } catch (e) {
      return false;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
      return false;
    }
  }

  if (!_isIP(host, 0, regexp) &&
      !_isFQDN(
        host,
        requireTld: requireTld,
        allowUnderscores: allowUnderscore,
      ) &&
      host != 'localhost') {
    return false;
  }

  if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
    return false;
  }

  if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
    return false;
  }

  return true;
}

/// Check if the string [str] is a fully qualified domain name (e.g., domain.com).
///
/// * [requireTld] sets if TLD is required
/// * [allowUnderscores] sets if underscores are allowed
bool _isFQDN(
  String str, {
  bool requireTld = true,
  bool allowUnderscores = false,
}) {
  final List<String> parts = str.split('.');
  if (requireTld) {
    final String tld = parts.removeLast();
    if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  final String partPattern = allowUnderscores
      ? r'^[a-z\u00a1-\uffff0-9-_]+$'
      : r'^[a-z\u00a1-\uffff0-9-]+$';

  for (final String part in parts) {
    if (!RegExp(partPattern).hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' ||
        part[part.length - 1] == '-' ||
        part.contains('---') ||
        (allowUnderscores && part.contains('__'))) {
      return false;
    }
  }
  return true;
}

/// Remove and return the first element from a list.
T _shift<T>(List<T> l) {
  if (l.isNotEmpty) {
    final T first = l.first;
    l.removeAt(0);
    return first;
  }
  return null as T;
}

bool _isCreditCard(String value, RegExp regex) {
  final String sanitized = value.replaceAll(RegExp('[^0-9]+'), '');
  if (!regex.hasMatch(sanitized)) {
    return false;
  }

  // Luhn algorithm
  int sum = 0;
  String digit;
  bool shouldDouble = false;

  for (int i = sanitized.length - 1; i >= 0; i--) {
    digit = sanitized.substring(i, i + 1);
    int tmpNum = int.parse(digit);

    if (shouldDouble) {
      tmpNum *= 2;
      if (tmpNum >= 10) {
        sum += (tmpNum % 10) + 1;
      } else {
        sum += tmpNum;
      }
    } else {
      sum += tmpNum;
    }
    shouldDouble = !shouldDouble;
  }

  return (sum % 10 == 0);
}

// ignore_for_file: always_specify_types, prefer_const_constructors, public_member_api_docs

import 'localization/l10n.dart';

typedef Validator<T extends Object?> = String? Function(T);

// Emptiness check validator:
Validator<T?> isRequired<T extends Object>(
  Validator<T>? v, {
  String? isRequiredMessage,
}) {
  String? finalValidator(T? value) {
    final (isValid, transformedValue) = _isRequiredValidateAndConvert(value);
    if (!isValid) {
      return isRequiredMessage ??
          FormBuilderLocalizations.current.requiredErrorText;
    }
    return v?.call(transformedValue!);
  }

  return finalValidator;
}

Validator<T?> isOptional<T extends Object>(
  Validator<T>? v, {
  String? isOptionalMessage,
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
    {String? isStringMessage}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isStringValidateAndConvert(value);
    if (!isValid) {
      return isStringMessage ?? 'This field requires a valid string.';
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

Validator<T> isInt<T extends Object>(Validator<int>? v,
    {String? isIntMessage}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isIntValidateAndConvert(value);
    if (!isValid) {
      return isIntMessage ?? FormBuilderLocalizations.current.integerErrorText;
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

Validator<T> isNum<T extends Object>(Validator<num>? v,
    {String? isNumMessage}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isNumValidateAndConvert(value);
    if (!isValid) {
      return isNumMessage ?? FormBuilderLocalizations.current.numericErrorText;
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
    {String? isBoolMessage}) {
  String? finalValidator(T value) {
    final (isValid, typeTransformedValue) = _isBoolValidateAndConvert(value);
    if (!isValid) {
      return isBoolMessage ?? FormBuilderLocalizations.current.numericErrorText;
    }
    return v?.call(typeTransformedValue!);
  }

  return finalValidator;
}

(bool, bool?) _isBoolValidateAndConvert<T extends Object>(T value) {
  if (value is bool) {
    return (true, value);
  }
  if (value is String) {
    final bool? candidateValue = bool.tryParse(value.toLowerCase());
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
  String? passwordMessage,
}) {
  final andValidator = and([
    _minL(minLength),
    _maxL(maxLength),
    hasMinUppercase(min: minUppercaseCount),
    hasMinLowercase(min: minLowercaseCount),
    hasMinNumeric(min: minNumberCount),
    hasMinSpecial(min: minSpecialCharCount),
  ]);
  return passwordMessage != null
      ? msg(passwordMessage, andValidator)
      : andValidator;
}

final _upperCaseRegex = RegExp('[A-Z]');
final _lowerCaseRegex = RegExp('[a-z]');
final _numericRegex = RegExp('[0-9]');
final _specialRegex = RegExp('[^A-Za-z0-9]');
Validator<String> hasMinUppercase({
  int min = 1,
  RegExp? regex,
  String Function(int)? hasMinUppercaseMessage,
}) {
  return (value) {
    return (regex ?? _upperCaseRegex).allMatches(value).length >= min
        ? null
        : hasMinUppercaseMessage?.call(min) ??
            FormBuilderLocalizations.current
                .containsUppercaseCharErrorText(min);
  };
}

Validator<String> hasMinLowercase({
  int min = 1,
  RegExp? regex,
  String Function(int)? hasMinLowercaseMessage,
}) {
  return (value) {
    return (regex ?? _lowerCaseRegex).allMatches(value).length >= min
        ? null
        : hasMinLowercaseMessage?.call(min) ??
            FormBuilderLocalizations.current
                .containsLowercaseCharErrorText(min);
  };
}

Validator<String> hasMinNumeric({
  int min = 1,
  RegExp? regex,
  String Function(int)? hasMinNumericMessage,
}) {
  return (value) {
    return (regex ?? _numericRegex).allMatches(value).length >= min
        ? null
        : hasMinNumericMessage?.call(min) ??
            FormBuilderLocalizations.current.containsNumberErrorText(min);
  };
}

Validator<String> hasMinSpecial({
  int min = 1,
  RegExp? regex,
  String Function(int)? hasMinSpecialMessage,
}) {
  return (value) {
    return (regex ?? _specialRegex).allMatches(value).length >= min
        ? null
        : hasMinSpecialMessage?.call(min) ??
            FormBuilderLocalizations.current.containsSpecialCharErrorText(min);
  };
}

Validator<String> match(
  RegExp regex, {
  String? matchMessage,
}) {
  return (value) {
    return regex.hasMatch(value)
        ? null
        : matchMessage ?? FormBuilderLocalizations.current.matchErrorText;
  };
}

final _uuidRegex = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);
Validator<String> uuid({
  RegExp? regex,
  String? uuidMessage,
}) {
  return (value) {
    return (regex ?? _uuidRegex).hasMatch(value)
        ? null
        : uuidMessage ?? FormBuilderLocalizations.current.uuidErrorText;
  };
}

final _creditCardRegex = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);
Validator<String> creditCard({
  RegExp? regex,
  String? creditCardMessage,
}) {
  return (value) {
    return isCreditCard(value, regex ?? _creditCardRegex)
        ? null
        : creditCardMessage ??
            FormBuilderLocalizations.current.creditCardErrorText;
  };
}

final _phoneNumberRegex = RegExp(
  r'^\+?(\d{1,4}[\s.-]?)?(\(?\d{1,4}\)?[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,9})$',
);
Validator<String> phoneNumber({
  RegExp? regex,
  String? phoneNumberMessage,
}) {
  return (value) {
    final String phoneNumber = value.replaceAll(' ', '').replaceAll('-', '');
    return (regex ?? _phoneNumberRegex).hasMatch(phoneNumber)
        ? null
        : phoneNumberMessage ?? FormBuilderLocalizations.current.phoneErrorText;
  };
}

Validator<String> contains(
  String substring, {
  bool caseSensitive = true,
  String Function(String)? containsMessage,
}) {
  return (value) {
    if (substring.isEmpty) {
      return null;
    } else if (caseSensitive
        ? value.contains(substring)
        : value.toLowerCase().contains(substring.toLowerCase())) {
      return null;
    }
    return containsMessage?.call(substring) ??
        FormBuilderLocalizations.current.containsErrorText(substring);
  };
}

Validator<String> email({
  RegExp? regex,
  String? emailMessage,
}) {
  final defaultRegex = RegExp(
    r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
  );
  return (value) {
    return (regex ?? defaultRegex).hasMatch(value.toLowerCase())
        ? null
        : emailMessage ?? FormBuilderLocalizations.current.emailErrorText;
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
  String? urlMessage,
}) {
  const defaultProtocols = <String>['http', 'https', 'ftp'];
  return (value) {
    return (regex != null && !regex.hasMatch(value)) ||
            !isURL(
              value,
              protocols: protocols ?? defaultProtocols,
              requireTld: requireTld,
              requireProtocol: requireProtocol,
              allowUnderscore: allowUnderscore,
              hostWhitelist: hostWhitelist ?? [],
              hostBlacklist: hostBlacklist ?? [],
            )
        ? urlMessage ?? FormBuilderLocalizations.current.urlErrorText
        : null;
  };
}

Validator<String> ip({
  int version = 4,
  RegExp? regex,
  String? ipMessage,
}) {
  return (value) {
    return !isIP(value, version, regex)
        ? ipMessage ?? FormBuilderLocalizations.current.ipErrorText
        : null;
  };
}

// T validators
Validator<T> equal<T extends Object?>(T value,
    {String Function(String)? equalMessage}) {
  return (input) {
    final valueString = value.toString();
    return value == input
        ? null
        : equalMessage?.call(valueString) ??
            FormBuilderLocalizations.current.equalErrorText(valueString);
  };
}

Validator<T> minLength<T extends Object>(int minLength,
    {String Function(int)? minLengthMessage}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength < minLength
        ? minLengthMessage?.call(minLength) ??
            FormBuilderLocalizations.current.minLengthErrorText(minLength)
        : null;
  };
}

Validator<T> maxLength<T extends Object>(int maxLength,
    {String Function(int)? maxLengthMessage}) {
  return (value) {
    // I think it makes more sense to say that scalar objects has length 1 instead of 0.
    int valueLength = 1;

    if (value is String) valueLength = value.length;
    if (value is Iterable) valueLength = value.length;
    if (value is Map) valueLength = value.length;

    return valueLength > maxLength
        ? maxLengthMessage?.call(maxLength) ??
            FormBuilderLocalizations.current.maxLengthErrorText(maxLength)
        : null;
  };
}

// Numeric validators
Validator<T> max<T extends num>(T? max,
    {T Function()? dynMax,
    bool inclusive = true,
    String Function(num)? maxMessage}) {
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
        : maxMessage?.call(actualMax) ??
            FormBuilderLocalizations.current.maxErrorText(actualMax);
  };
}

Validator<T> min<T extends num>(T? min,
    {T Function()? dynMin,
    bool inclusive = true,
    String Function(num)? minMessage}) {
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
        : minMessage?.call(actualMin) ??
            FormBuilderLocalizations.current.minErrorText(actualMin);
  };
}

Validator<T> greaterThan<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? greaterThanMessage]) {
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
        : greaterThanMessage?.call(actualN) ??
            'Value must be greater than $actualN';
  };
}

Validator<T> greaterThanOrEqual<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? greaterThanOrEqualMessage]) {
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
        : greaterThanOrEqualMessage?.call(actualN) ??
            'Value must be greater than or equal to $actualN';
  };
}

Validator<T> lessThan<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? lessThanMessage]) {
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
        : lessThanMessage?.call(actualN) ?? 'Value must be less than $actualN';
  };
}

Validator<T> lessThanOrEqual<T extends num>(T? n,
    [T Function()? dynN, String Function(num)? lessThanOrEqualMessage]) {
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
        : lessThanOrEqualMessage?.call(actualN) ??
            'Value must be less than or equal to $actualN';
  };
}

Validator<T> between<T extends num>(T? min, T? max,
    {T Function()? dynMin,
    T Function()? dynMax,
    bool leftInclusive = true,
    bool rightInclusive = true,
    String Function(num min, num max)? betweenMessage}) {
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
        : betweenMessage?.call(actualMin, actualMax) ??
            'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$actualMin and less than ${rightInclusive ? 'or equal to ' : ''}$actualMax';
  };
}

const gt = greaterThan;
const gtE = greaterThanOrEqual;
const lt = lessThan;
const ltE = lessThanOrEqual;
const bw = between;

// bool validators
String? isTrue(bool value) =>
    value ? null : FormBuilderLocalizations.current.mustBeTrueErrorText;

String? isFalse(bool value) =>
    value ? FormBuilderLocalizations.current.mustBeFalseErrorText : null;

// msg wrapper
/// Replaces any inner message with [errorMessage]. It is useful also for changing
/// the message of direct validator implementations, like [isTrue] or [isFalse].
Validator<T> withMessage<T extends Object?>(
  String errorMessage,
  Validator<T> v,
) {
  return (value) {
    final vErrorMessage = v(value);
    if (vErrorMessage != null) {
      return errorMessage;
    }
    return null;
  };
}

const msg = withMessage;

//******************************************************************************
//*                              Aux functions                                 *
//******************************************************************************
const int _maxUrlLength = 2083;
final RegExp _ipv4Maybe =
    RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final RegExp _ipv6 = RegExp(
  r'^((?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(?::0{1,4}){0,1}:){0,1}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$',
);

/// Check if the string [str] is IP [version] 4 or 6.
///
/// * [version] is a String or an `int`.
bool isIP(String? str, int version, RegExp? regex) {
  if (version != 4 && version != 6) {
    return isIP(str, 4, regex) || isIP(str, 6, regex);
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
bool isURL(
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
    protocol = shift(split).toLowerCase();
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol == true) {
    return false;
  }
  final String str1 = split.join('://');

  // check hash
  split = str1.split('#');
  final String str2 = shift(split);
  hash = split.join('#');
  if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str2.split('?');
  final String str3 = shift(split);
  query = split.join('?');
  if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str3.split('/');
  final String str4 = shift(split);
  path = split.join('/');
  if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str4.split('@');
  if (split.length > 1) {
    auth = shift(split);
    if (auth?.contains(':') ?? false) {
      user = shift(auth!.split(':'));
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
  host = shift(split).toLowerCase();
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

  if (!isIP(host, 0, regexp) &&
      !isFQDN(
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
bool isFQDN(
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
T shift<T>(List<T> l) {
  if (l.isNotEmpty) {
    final T first = l.first;
    l.removeAt(0);
    return first;
  }
  return null as T;
}

bool isCreditCard(String value, RegExp regex) {
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

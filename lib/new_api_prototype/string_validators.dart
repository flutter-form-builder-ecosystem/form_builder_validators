import '../localization/l10n.dart';
import 'composition_validators.dart';
import 'constants.dart';
import 'generic_type_validators.dart';
import 'override_error_msg.dart';

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
/// `FormBuilderLocalizations.current.containsNumberErrorText(min)`, if
/// [hasMinNumericCharsMsg] is not provided.
///
///
/// # Caveats
/// - The default method for calculating special chars is to make the difference
/// between the total number of chars and the sum of digits and alphabetical
/// chars. The alphabetical chars are counted as those which are affected by
/// the String methods toLowercase/toUppercase.
/// - By default, the validator returned counts the special chars using a
/// language independent unicode mapping, which may not work for some languages.
/// For that situations, the user can provide a custom special counter
/// function.
///
/// ```dart
/// // US-ASCII special chars
/// final validator = hasMinSpecialChars(customSpecialCounter:(v)=>RegExp('[^A-Za-z0-9]'));
/// ```
///
/// # Errors
/// - Throws an [AssertionError] if [min] is not positive (< 1).
///
///
Validator<String> hasMinSpecialChars({
  int min = 1,
  int Function(String)? customSpecialCounter,
  String Function(int)? hasMinSpecialCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (value) {
    // todo (optimize) avoid calculating _upperAndLowerCaseCounter when user provides customSpecialCounter
    final (lowerCount: lowerCount, upperCount: upperCount) =
        _upperAndLowerCaseCounter(value);
    final specialCount = value.length -
        (lowerCount + upperCount + _numericRegex.allMatches(value).length);

    return (customSpecialCounter?.call(value) ?? specialCount) >= min
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

import '../../../localization/l10n.dart';
import '../collection_validators.dart' as collection_val;
import '../constants.dart';
import '../core_validators/composition_validators.dart';
import '../core_validators/override_error_msg.dart';

/// {@template validator_password}
/// Creates a composite validator for password validation that enforces multiple
/// password strength requirements simultaneously.
///
/// This validator combines multiple validation rules including length constraints,
/// character type requirements (uppercase, lowercase, numbers, and special characters),
/// and allows for custom error message overriding.
///
/// ## Parameters
/// - `minLength` (`int`): Minimum required length for the password. Defaults to `8`
/// - `maxLength` (`int`): Maximum allowed length for the password. Defaults to `32`
/// - `minUppercaseCount` (`int`): Minimum required uppercase characters. Defaults to `1`
/// - `minLowercaseCount` (`int`): Minimum required lowercase characters. Defaults to `1`
/// - `minNumberCount` (`int`): Minimum required numeric characters. Defaults to `1`
/// - `minSpecialCharCount` (`int`): Minimum required special characters. Defaults to `1`
/// - `passwordMsg` (`String?`): Optional custom error message that overrides all
///   validation error messages. When `null`, individual validator messages are used
///
/// ## Returns
/// Returns a `Validator<String>` that combines all specified password requirements
/// into a single validator. The validator returns null if all conditions are met,
/// otherwise returns the appropriate error message.
///
/// ## Examples
/// ```dart
/// // Default password validation
/// final validator = password();
///
/// // Custom requirements
/// final strictValidator = password(
///   minLength: 12,
///   minUppercaseCount: 2,
///   minSpecialCharCount: 2,
///   passwordMsg: 'Password does not meet security requirements'
/// );
/// ```
///
/// ## Caveats
/// - When `passwordMsg` is provided, individual validation failure details
///   are not available to the user
/// {@endtemplate}
Validator<String> password({
  int minLength = 8,
  int maxLength = 32,
  int minUppercaseCount = 1,
  int minLowercaseCount = 1,
  int minNumberCount = 1,
  int minSpecialCharCount = 1,
  String? passwordMsg,
}) {
  final Validator<String> andValidator = and(<Validator<String>>[
    collection_val.minLength(minLength),
    collection_val.maxLength(maxLength),
    hasMinUppercaseChars(min: minUppercaseCount),
    hasMinLowercaseChars(min: minLowercaseCount),
    hasMinNumericChars(min: minNumberCount),
    hasMinSpecialChars(min: minSpecialCharCount),
  ]);
  return passwordMsg != null
      ? overrideErrorMsg((_) => passwordMsg, andValidator)
      : andValidator;
}

final RegExp _numericRegex = RegExp('[0-9]');

({int upperCount, int lowerCount}) _upperAndLowerCaseCounter(String value) {
  int uppercaseCount = 0;
  int lowercaseCount = 0;
  final String upperCaseVersion = value.toUpperCase();
  final String lowerCaseVersion = value.toLowerCase();
  // initial version: 1.0
  final RuneIterator o = value.runes.iterator;
  final RuneIterator u = upperCaseVersion.runes.iterator;
  final RuneIterator l = lowerCaseVersion.runes.iterator;
  while (o.moveNext() && u.moveNext() && l.moveNext()) {
    if (o.current == u.current && o.current != l.current) {
      uppercaseCount++;
    } else if (o.current != u.current && o.current == l.current) {
      lowercaseCount++;
    }
  }
  return (lowerCount: lowercaseCount, upperCount: uppercaseCount);
}

/// {@template validator_has_min_uppercase_chars}
/// Creates a validator function that checks if the [String] input contains a
/// minimum number of uppercase characters. The validator returns `null` for
/// valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [hasMinUppercaseCharsMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.containsUppercaseCharErrorText(min)`.
///
/// ## Parameters
/// - `min` (`int`): The minimum number of uppercase characters required. Defaults
///   to 1.
/// - `customUppercaseCounter` (`int Function(String)?`): Optional custom function
///   to count uppercase characters. If not provided, uses a default Unicode-based
///   counter.
/// - `hasMinUppercaseCharsMsg` (`String Function(String input, int min)?`):
///   Optional function to generate custom error messages. Receives the input and
///   the minimum uppercase count required and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<String>` function that takes a string input and returns:
/// - `null` if the input contains at least [min] uppercase characters
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is less than 1
///
/// ## Examples
/// ```dart
/// // Basic usage with default parameters
/// final validator = hasMinUppercaseChars();
/// print(validator('Hello')); // Returns null
/// print(validator('hello')); // Returns error message
///
/// // Custom minimum requirement
/// final strictValidator = hasMinUppercaseChars(min: 2);
/// print(strictValidator('HEllo')); // Returns null
/// print(strictValidator('Hello')); // Returns error message
///
/// // Custom error message
/// final customValidator = hasMinUppercaseChars(
///   hasMinUppercaseCharsMsg: (_, min) => 'Need $min uppercase letters!',
/// );
/// ```
///
/// ## Caveats
/// - The default counter uses language-independent Unicode mapping, which may not
///   work correctly for all languages. Custom uppercase counter function should
///   be provided for special language requirements
/// {@endtemplate}
Validator<String> hasMinUppercaseChars({
  int min = 1,
  int Function(String)? customUppercaseCounter,
  String Function(String input, int min)? hasMinUppercaseCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');

  return (String input) {
    int uppercaseCount = customUppercaseCounter?.call(input) ??
        _upperAndLowerCaseCounter(input).upperCount;

    return uppercaseCount >= min
        ? null
        : hasMinUppercaseCharsMsg?.call(input, min) ??
            FormBuilderLocalizations.current
                .containsUppercaseCharErrorText(min);
  };
}

/// {@template validator_has_min_lowercase_chars}
/// Creates a validator function that checks if the [String] input contains a
/// minimum number of lowercase characters. The validator returns `null` for
/// valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [hasMinLowercaseCharsMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.containsLowercaseCharErrorText(min)`.
///
/// ## Parameters
/// - `min` (`int`): The minimum number of lowercase characters required. Defaults
///   to 1.
/// - `customLowercaseCounter` (`int Function(String)?`): Optional custom function
///   to count lowercase characters. If not provided, uses a default Unicode-based
///   counter.
/// - `hasMinLowercaseCharsMsg` (`String Function(String input, int min)?`):
///   Optional function to generate custom error messages. Receives the input and
///   the minimum lowercase count required and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<String>` function that takes a string input and returns:
/// - `null` if the input contains at least [min] lowercase characters
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is less than 1
///
/// ## Examples
/// ```dart
/// // Basic usage with default parameters
/// final validator = hasMinLowercaseChars();
/// print(validator('hello')); // Returns null
/// print(validator('HELLO')); // Returns error message
///
/// // Custom minimum requirement
/// final strictValidator = hasMinLowercaseChars(min: 2);
/// print(strictValidator('hEllo')); // Returns null
/// print(strictValidator('HELlO')); // Returns error message
///
/// // Custom error message
/// final customValidator = hasMinLowercaseChars(
///   hasMinLowercaseCharsMsg: (_, min) => 'Need $min lowercase letters!',
/// );
/// ```
///
/// ## Caveats
/// - The default counter uses language-independent Unicode mapping, which may not
///   work correctly for all languages. Custom lowercase counter function should
///   be provided for special language requirements
/// {@endtemplate}
Validator<String> hasMinLowercaseChars({
  int min = 1,
  int Function(String)? customLowercaseCounter,
  String Function(String input, int min)? hasMinLowercaseCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (String input) {
    int lowercaseCount = customLowercaseCounter?.call(input) ??
        _upperAndLowerCaseCounter(input).lowerCount;

    return lowercaseCount >= min
        ? null
        : hasMinLowercaseCharsMsg?.call(input, min) ??
            FormBuilderLocalizations.current
                .containsLowercaseCharErrorText(min);
  };
}

/// {@template validator_has_min_numeric_chars}
/// Creates a validator function that checks if the [String] input contains a
/// minimum number of numeric characters (0-9). The validator returns `null` for
/// valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [hasMinNumericCharsMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.containsNumberErrorText(min)`.
///
/// ## Parameters
/// - `min` (`int`): The minimum number of numeric characters required. Defaults
///   to 1.
/// - `customNumericCounter` (`int Function(String)?`): Optional custom function
///   to count numeric characters. If not provided, uses a default regex-based
///   counter matching digits 0-9.
/// - `hasMinNumericCharsMsg` (`String Function(String input, int min)?`):
///   Optional function to generate custom error messages. Receives the input and
///   the minimum numeric count required and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<String>` function that takes a string input and returns:
/// - `null` if the input contains at least [min] numeric characters
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is less than 1
///
/// ## Examples
/// ```dart
/// // Basic usage with default parameters
/// final validator = hasMinNumericChars();
/// print(validator('hello123')); // Returns null
/// print(validator('hello')); // Returns error message
///
/// // Custom minimum requirement
/// final strictValidator = hasMinNumericChars(min: 2);
/// print(strictValidator('hello12')); // Returns null
/// print(strictValidator('hello1')); // Returns error message
///
/// // Custom error message
/// final customValidator = hasMinNumericChars(
///   hasMinNumericCharsMsg: (_, min) => 'Need $min numbers!',
/// );
///
/// // Custom numeric counter for special cases
/// final customCounter = hasMinNumericChars(
///   customNumericCounter: countNumericDigits, // From a specialized package, for example.
/// );
/// ```
///
/// ## Caveats
/// - The default counter uses a regular expression matching digits 0-9, which may
///   not work correctly for all languages or number systems. Custom numeric counter
///   function should be provided for special numbering requirements
/// {@endtemplate}
Validator<String> hasMinNumericChars({
  int min = 1,
  int Function(String)? customNumericCounter,
  String Function(String input, int min)? hasMinNumericCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (String input) {
    final int numericCount = customNumericCounter?.call(input) ??
        _numericRegex.allMatches(input).length;
    return numericCount >= min
        ? null
        : hasMinNumericCharsMsg?.call(input, min) ??
            FormBuilderLocalizations.current.containsNumberErrorText(min);
  };
}

/// {@template validator_has_min_special_chars}
/// Creates a validator function that checks if the [String] input contains a
/// minimum number of special characters. The validator returns `null` for
/// valid input and an error message for invalid input.
///
/// If validation fails and no custom error message generator is provided via
/// [hasMinSpecialCharsMsg], returns the default localized error message from
/// `FormBuilderLocalizations.current.containsSpecialCharErrorText(min)`.
///
/// ## Parameters
/// - `min` (`int`): The minimum number of special characters required. Defaults
///   to 1.
/// - `customSpecialCounter` (`int Function(String)?`): Optional custom function
///   to count special characters. If not provided, uses a default calculation
///   that considers special characters as any character that is neither
///   alphanumeric.
/// - `hasMinSpecialCharsMsg` (`String Function(String input, int min)?`):
///   Optional function to generate custom error messages. Receives the input and
///   the minimum special character count required and returns an error message string.
///
/// ## Returns
/// Returns a `Validator<String>` function that takes a string input and returns:
/// - `null` if the input contains at least [min] special characters
/// - An error message string if the validation fails
///
/// ## Throws
/// - `AssertionError`: When [min] is less than 1
///
/// ## Examples
/// ```dart
/// // Basic usage with default parameters
/// final validator = hasMinSpecialChars();
/// print(validator('hello@world')); // Returns null
/// print(validator('helloworld')); // Returns error message
///
/// // Custom minimum requirement
/// final strictValidator = hasMinSpecialChars(min: 2);
/// print(strictValidator('hello@#world')); // Returns null
/// print(strictValidator('hello@world')); // Returns error message
///
/// // Custom error message
/// final customValidator = hasMinSpecialChars(
///   hasMinSpecialCharsMsg: (_, min) => 'Need $min special characters!',
/// );
///
/// // Custom special character counter for US-ASCII
/// final asciiValidator = hasMinSpecialChars(
///   customSpecialCounter: (v) => RegExp('[^A-Za-z0-9]').allMatches(v).length,
/// );
/// ```
///
/// ## Caveats
/// - The default counter uses language-independent Unicode mapping, which may not
///   work correctly for all languages. Custom special character counter function
///   should be provided for specific character set requirements
/// {@endtemplate}
Validator<String> hasMinSpecialChars({
  int min = 1,
  int Function(String)? customSpecialCounter,
  String Function(String input, int min)? hasMinSpecialCharsMsg,
}) {
  assert(min > 0, 'min must be positive (at least 1)');
  return (String input) {
    int specialCount;
    if (customSpecialCounter == null) {
      final (lowerCount: int lowerCount, upperCount: int upperCount) =
          _upperAndLowerCaseCounter(input);
      specialCount = input.length -
          (lowerCount + upperCount + _numericRegex.allMatches(input).length);
    } else {
      specialCount = customSpecialCounter.call(input);
    }

    return specialCount >= min
        ? null
        : hasMinSpecialCharsMsg?.call(input, min) ??
            FormBuilderLocalizations.current.containsSpecialCharErrorText(min);
  };
}

/// {@template validator_match}
/// Creates a validator function that checks if the [String] input matches a given
/// regular expression pattern. The validator returns `null` for valid input and
/// an error message for invalid input.
///
/// If validation fails and no custom error message is provided via [matchMsg],
/// returns the default localized error message from
/// `FormBuilderLocalizations.current.matchErrorText`.
///
/// ## Parameters
/// - `regex` (`RegExp`): The regular expression pattern to match against the input
///   string.
/// - `matchMsg` (`String Function(String input)?`): Optional custom error message
/// to display when the validation fails. If not provided, uses the default
/// localized error message.
///
/// ## Returns
/// Returns a `Validator<String>` function that takes a string input and returns:
/// - `null` if the input matches the provided regular expression pattern
/// - An error message string if the validation fails
///
/// ## Examples
/// ```dart
/// // Basic email validation
/// final emailValidator = match(
///   emailRegExp,
///   matchMsg: (_)=>'Please enter a valid email address',
/// );
/// print(emailValidator('user@example.com')); // Returns null
/// print(emailValidator('invalid-email')); // Returns error message
/// ```
///
/// ## Caveats
/// - Complex regular expressions may impact performance for large inputs
/// - Consider using more specific validators for common patterns like email
///   or phone number validation
/// {@endtemplate}
Validator<String> match(
  RegExp regex, {
  String Function(String input)? matchMsg,
}) {
  return (String input) {
    return regex.hasMatch(input)
        ? null
        : matchMsg?.call(input) ??
            FormBuilderLocalizations.current.matchErrorText;
  };
}

final RegExp _uuidRegex = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);
Validator<String> uuid({
  RegExp? regex,
  String? uuidMsg,
}) {
  return (String value) {
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

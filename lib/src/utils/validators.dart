import 'dart:convert';

import 'helpers.dart';

/// {@template email_template}
/// This regex matches an email address.
///
/// - It allows various characters, including letters, digits, and special characters.
/// - It supports international characters.
/// - It checks for the presence of an "@" symbol followed by a valid domain name.
///
/// Examples: user@example.com, user.name+tag@example.co.uk
/// {@endtemplate}
RegExp _email = RegExp(
  r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
);

/// {@template credit_card_template}
/// This regex matches credit card numbers from major brands.
///
/// - It supports Visa, MasterCard, American Express, Diners Club, Discover, and JCB cards.
/// - It validates the number of digits and prefixes for each card type.
///
/// Examples: 4111111111111111, 5500000000000004, 340000000000009
/// {@endtemplate}
RegExp _creditCard = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

/// {@template phone_number_template}
/// This regex matches international phone numbers.
///
/// - It supports optional country codes.
/// - It allows spaces, dashes, and dots as separators.
/// - It validates the number of digits in the phone number.
///
/// Examples: +1-800-555-5555, 1234567890
/// {@endtemplate}
RegExp _phoneNumber = RegExp(r'^\+?(\d{1,4}[\s-])?(?!0+\s+,?$)\d{1,15}$');

/// {@template credit_card_expiration_template}
/// This regex matches credit card expiration dates.
///
/// - It checks for a valid month (01-12).
/// - It checks for a valid year (two digits).
///
/// Examples: 01/23, 12/25
/// {@endtemplate}
RegExp _creditCardExpirationDate = RegExp(r'^[0-1][0-9]/\d{2}$');

/// {@template hex_template}
/// This regex matches hexadecimal color codes.
///
/// - It starts with a # character.
/// - It is followed by exactly six characters, each of which is a hexadecimal digit (0-9, a-f, or A-F).
///
/// Examples: #1a2b3c, #ABCDEF
/// {@endtemplate}
RegExp _hex = RegExp(r'^#[0-9a-fA-F]{6}$');

/// {@template rgb_template}
/// This regex matches RGB color values.
///
/// - It checks for the rgb() format.
/// - It allows up to three digits for each color value (0-255).
///
/// Examples: rgb(255, 0, 0), rgb(123, 123, 123)
/// {@endtemplate}
RegExp _rgb = RegExp(r'^rgb\(\d{1,3},\s*\d{1,3},\s*\d{1,3}\)$');

/// {@template hsl_template}
/// This regex matches HSL color values.
///
/// - It checks for the hsl() format.
/// - It allows integers for hue and percentages for saturation and lightness.
///
/// Examples: hsl(360, 100%, 50%), hsl(120, 75%, 25%)
/// {@endtemplate}
RegExp _hsl = RegExp(r'^hsl\(\d+,\s*\d+%,\s*\d+%\)$');

/// {@template alphabetical_template}
/// This regex matches only alphabetical characters.
///
/// - It allows both uppercase and lowercase letters.
///
/// Examples: abcdef, XYZ
/// {@endtemplate}
RegExp _alphabetical = RegExp(r'^[a-zA-Z]+$');

/// {@template uuid_template}
/// This regex matches UUIDs (version 4).
///
/// - It validates the format of a UUID, including hyphens.
///
/// Examples: 123e4567-e89b-12d3-a456-426614174000
/// {@endtemplate}
RegExp _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

/// {@template mac_address_template}
/// This regex matches MAC addresses.
///
/// - It consists of pairs of hexadecimal digits.
/// - Each pair is separated by colons or hyphens.
///
/// Examples: 00:1A:2B:3C:4D:5E, 00-1A-2B-3C-4D-5E
/// {@endtemplate}
RegExp _macAddress = RegExp(r'^[0-9A-Fa-f]{2}$');

/// {@template bic_template}
/// This regex matches BIC (Bank Identifier Code).
///
/// - It consists of 8 or 11 characters.
/// - It starts with four letters (bank code), followed by two letters (country code), two characters (location code), and optionally three characters (branch code).
///
/// Examples: DEUTDEFF, NEDSZAJJXXX
/// {@endtemplate}
RegExp _bic = RegExp(r'^[A-Z]{4}[A-Z]{2}\w{2}(\w{3})?$');

int _maxUrlLength = 2083;

/// check if the string [str] is an email
bool isEmail(String str) {
  return _email.hasMatch(str.toLowerCase());
}

/// check if the string [str] is a URL
///
/// * [protocols] sets the list of allowed protocols
/// * [requireTld] sets if TLD is required
/// * [requireProtocol] is a `bool` that sets if protocol is required for validation
/// * [allowUnderscore] sets if underscores are allowed
/// * [hostWhitelist] sets the list of allowed hosts
/// * [hostBlacklist] sets the list of disallowed hosts
bool isURL(
  String? str, {
  List<String?> protocols = const <String?>['http', 'https', 'ftp'],
  bool requireTld = true,
  bool requireProtocol = false,
  bool allowUnderscore = false,
  List<String> hostWhitelist = const <String>[],
  List<String> hostBlacklist = const <String>[],
}) {
  if (str == null ||
      str.isEmpty ||
      str.length > _maxUrlLength ||
      str.startsWith('mailto:')) {
    return false;
  }
  int port;
  String? protocol;
  String? auth;
  String user;
  String host;
  String hostname;
  String portStr;
  String path;
  String query;
  String hash;

  // check protocol
  List<String> split = str.split('://');
  if (split.length > 1) {
    protocol = shift(split).toLowerCase();
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol == true) {
    return false;
  }
  str = split.join('://');

  // check hash
  split = str.split('#');
  str = shift(split);
  hash = split.join('#');
  if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str.split('?');
  str = shift(split);
  query = split.join('?');
  if (query.isNotEmpty && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str.split('/');
  str = shift(split);
  path = split.join('/');
  if (path.isNotEmpty && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str.split('@');
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

  if (!isIP(host, null) &&
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

/// check if the string [str] is a fully qualified domain name (e.g. domain.com).
///
/// * [requireTld] sets if TLD is required
/// * [allowUnderscore] sets if underscores are allowed
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

  for (final String part in parts) {
    if (allowUnderscores) {
      if (part.contains('__')) {
        return false;
      }
    }
    if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' ||
        part[part.length - 1] == '-' ||
        part.contains('---')) {
      return false;
    }
  }
  return true;
}

/// check if the string is a credit card
bool isCreditCard(String str) {
  final String sanitized = str.replaceAll(RegExp('[^0-9]+'), '');
  if (!_creditCard.hasMatch(sanitized)) {
    return false;
  }

  // Luhn algorithm
  int sum = 0;
  String digit;
  bool shouldDouble = false;

  for (int i = sanitized.length - 1; i >= 0; i--) {
    digit = sanitized.substring(i, i + 1);
    int tmpNum = int.parse(digit);

    if (shouldDouble == true) {
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

/// check if the string is a valid phone number
bool isPhoneNumber(String str) {
  if (str.isEmpty) {
    return false;
  }
  final String phone = str.replaceAll(' ', '').replaceAll('-', '');
  return _phoneNumber.hasMatch(phone);
}

/// check if the string is a valid credit card expiration date
bool isCreditCardExpirationDate(String str) {
  // Check if the format matches MM/YY
  if (!_creditCardExpirationDate.hasMatch(str)) {
    return false;
  }

  // Extract month and year from the value
  final List<int> parts = str.split('/').map(int.parse).toList();
  final int month = parts[0];
  final int year = parts[1];

  // Check for valid month (1-12)
  if (month < 1 || month > 12) {
    return false;
  }

  return year > 0;
}

/// check if the string is not a expired credit card date
bool isNotExpiredCreditCardDate(String str) {
  final List<int> parts = str.split('/').map(int.parse).toList();
  final int month = parts[0];
  final int year = parts[1];

  final DateTime now = DateTime.now();
  final int currentYear = now.year % 100;
  final int currentMonth = now.month;

  if (year < currentYear) {
    return false;
  }

  if (year == currentYear && month < currentMonth) {
    return false;
  }

  return true;
}

/// check if the string is a color
/// * [formats] is a list of color formats to check
bool isColorCode(
  String value, {
  List<String> formats = const <String>['hex', 'rgb', 'hsl'],
}) {
  if (formats.contains('hex') && _hex.hasMatch(value)) {
    return true;
  } else if (formats.contains('rgb') && _rgb.hasMatch(value)) {
    final List<String> parts = value.substring(4, value.length - 1).split(',');
    for (final String part in parts) {
      final int colorValue = int.tryParse(part.trim()) ?? -1;
      if (colorValue < 0 || colorValue > 255) {
        return false;
      }
    }
    return true;
  } else if (formats.contains('hsl') && _hsl.hasMatch(value)) {
    final List<String> parts = value.substring(4, value.length - 1).split(',');
    for (int i = 0; i < parts.length; i++) {
      final int colorValue = int.tryParse(parts[i].trim()) ?? -1;
      if (i == 0) {
        // Hue
        if (colorValue < 0 || colorValue > 360) {
          return false;
        }
      } else if (colorValue < 0 || colorValue > 100) {
        return false;
      }
    }
    return true;
  }
  return false;
}

bool isAlphabetical(String value) {
  return _alphabetical.hasMatch(value);
}

/// check if the string is a valid UUID
bool isUUID(String value) {
  return _uuid.hasMatch(value);
}

/// check if the string is valid JSON
bool isJSON(String value) {
  try {
    jsonDecode(value);
    return true;
  } catch (e) {
    return false;
  }
}

/// check if the string is a valid latitude
bool isLatitude(String value) {
  value = value.replaceAll(',', '.');

  final double? latitude = double.tryParse(value);
  if (latitude == null) {
    return false;
  }
  return latitude >= -90 && latitude <= 90;
}

/// check if the string is a valid longitude
bool isLongitude(String value) {
  value = value.replaceAll(',', '.');

  final double? longitude = double.tryParse(value);
  if (longitude == null) {
    return false;
  }
  return longitude >= -180 && longitude <= 180;
}

/// check if the string is a valid base64 string
bool isBase64(String value) {
  try {
    base64Decode(value);
    return true;
  } catch (e) {
    return false;
  }
}

bool isOddNumber(String value) {
  final int number = int.tryParse(value) ?? 0;
  return number.isOdd;
}

bool isEvenNumber(String value) {
  final int number = int.tryParse(value) ?? 0;
  return number.isEven;
}

/// check if the string is a valid MAC address
bool isMACAddress(String value) {
  final String splitChar = value.contains(':') ? ':' : '-';
  final List<String> parts = value.split(splitChar);
  if (parts.length != 6) {
    return false;
  }

  for (final String part in parts) {
    if (part.length != 2 || !_macAddress.hasMatch(part)) {
      return false;
    }
  }
  return true;
}

/// check if the string is a valid IBAN
bool isIBAN(String iban) {
  iban = iban.replaceAll(' ', '').toUpperCase();

  if (iban.length < 15) {
    return false;
  }

  final String rearranged = iban.substring(4) + iban.substring(0, 4);
  final String numericIban = rearranged.split('').map((String char) {
    final int charCode = char.codeUnitAt(0);
    return charCode >= 65 && charCode <= 90 ? (charCode - 55).toString() : char;
  }).join();

  int remainder = int.parse(numericIban.substring(0, 9)) % 97;
  for (int i = 9; i < numericIban.length; i += 7) {
    remainder = int.parse(
          remainder.toString() +
              numericIban.substring(
                i,
                i + 7 < numericIban.length ? i + 7 : numericIban.length,
              ),
        ) %
        97;
  }

  return remainder == 1;
}

/// check if the string is a valid BIC
bool isBIC(String bic) {
  bic = bic.replaceAll(' ', '').toUpperCase();

  if (bic.length != 8 && bic.length != 11) {
    return false;
  }

  return _bic.hasMatch(bic);
}

bool isSingleLine(String value) {
  return !value.contains('\n') && !value.contains('\r');
}

import '../../../localization/l10n.dart';
import 'constants.dart';

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

/// {@macro validator_has_min_uppercase_chars}
Validator<String> hasMinUppercaseChars({
  int min = 1,
  int Function(String)? customUppercaseCounter,
  String Function(String input, int min)? hasMinUppercaseCharsMsg,
}) {
  if (min < 1) {
    throw ArgumentError.value(min, 'min', 'This argument must be at least 1');
  }

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

/// {@macro validator_has_min_lowercase_chars}
Validator<String> hasMinLowercaseChars({
  int min = 1,
  int Function(String)? customLowercaseCounter,
  String Function(String input, int min)? hasMinLowercaseCharsMsg,
}) {
  if (min < 1) {
    throw ArgumentError.value(min, 'min', 'This argument must be at least 1');
  }
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

/// {@macro validator_has_min_numeric_chars}
Validator<String> hasMinNumericChars({
  int min = 1,
  int Function(String)? customNumericCounter,
  String Function(String input, int min)? hasMinNumericCharsMsg,
}) {
  if (min < 1) {
    throw ArgumentError.value(min, 'min', 'This argument must be at least 1');
  }
  return (String input) {
    final int numericCount = customNumericCounter?.call(input) ??
        _numericRegex.allMatches(input).length;
    return numericCount >= min
        ? null
        : hasMinNumericCharsMsg?.call(input, min) ??
            FormBuilderLocalizations.current.containsNumberErrorText(min);
  };
}

/// {@macro validator_has_min_special_chars}
Validator<String> hasMinSpecialChars({
  int min = 1,
  int Function(String)? customSpecialCounter,
  String Function(String input, int min)? hasMinSpecialCharsMsg,
}) {
  if (min < 1) {
    throw ArgumentError.value(min, 'min', 'This argument must be at least 1');
  }
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

/// {@macro validator_match}
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

final RegExp _creditCardRegex = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

final RegExp _phoneNumberRegex = RegExp(
  r'^\+?(\d{1,4}[\s.-]?)?(\(?\d{1,4}\)?[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,4}[\s.-]?)?(\d{1,9})$',
);

Validator<String> phoneNumber({
  RegExp? regex,
  String? phoneNumberMsg,
}) {
  return (String value) {
    final String phoneNumber = value.replaceAll(' ', '').replaceAll('-', '');
    return (regex ?? _phoneNumberRegex).hasMatch(phoneNumber)
        ? null
        : phoneNumberMsg ?? FormBuilderLocalizations.current.phoneErrorText;
  };
}

Validator<String> creditCard({
  RegExp? regex,
  String? creditCardMsg,
}) {
  return (String value) {
    return _isCreditCard(value, regex ?? _creditCardRegex)
        ? null
        : creditCardMsg ?? FormBuilderLocalizations.current.creditCardErrorText;
  };
}

Validator<String> contains(
  String substring, {
  bool caseSensitive = true,
  String Function(String)? containsMsg,
}) {
  return (String value) {
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

//******************************************************************************
//*                              Aux functions                                 *
//******************************************************************************
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

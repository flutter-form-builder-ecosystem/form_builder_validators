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
    int uppercaseCount =
        customUppercaseCounter?.call(input) ??
        _upperAndLowerCaseCounter(input).upperCount;

    return uppercaseCount >= min
        ? null
        : hasMinUppercaseCharsMsg?.call(input, min) ??
              FormBuilderLocalizations.current.containsUppercaseCharErrorText(
                min,
              );
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
    int lowercaseCount =
        customLowercaseCounter?.call(input) ??
        _upperAndLowerCaseCounter(input).lowerCount;

    return lowercaseCount >= min
        ? null
        : hasMinLowercaseCharsMsg?.call(input, min) ??
              FormBuilderLocalizations.current.containsLowercaseCharErrorText(
                min,
              );
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
    final int numericCount =
        customNumericCounter?.call(input) ??
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
      specialCount =
          input.length -
          (lowerCount + upperCount + _numericRegex.allMatches(input).length);
    } else {
      specialCount = customSpecialCounter.call(input);
    }

    return specialCount >= min
        ? null
        : hasMinSpecialCharsMsg?.call(input, min) ??
              FormBuilderLocalizations.current.containsSpecialCharErrorText(
                min,
              );
  };
}

/// {@macro validator_match}
Validator<String> match(
  RegExp regExp, {
  String Function(String input)? matchMsg,
}) {
  return (String input) {
    return regExp.hasMatch(input)
        ? null
        : matchMsg?.call(input) ??
              FormBuilderLocalizations.current.matchErrorText;
  };
}

/// {@macro validator_not_match}
Validator<String> notMatch(
  RegExp regExp, {
  String Function(String input)? notMatchMsg,
}) {
  return (String input) {
    return !regExp.hasMatch(input)
        ? null
        : notMatchMsg?.call(input) ??
              FormBuilderLocalizations.current.notMatchErrorText;
  };
}

final RegExp _uuidRegex = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

/// {@macro validator_uuid}
Validator<String> uuid({
  RegExp? regex,
  String Function(String input)? uuidMsg,
}) {
  return (String input) {
    return (regex ?? _uuidRegex).hasMatch(input)
        ? null
        : uuidMsg?.call(input) ??
              FormBuilderLocalizations.current.uuidErrorText;
  };
}

/// {@macro validator_contains}
Validator<String> contains(
  String substring, {
  bool caseSensitive = true,
  String Function(String substring, String input)? containsMsg,
}) {
  final String lowercaseSubstring = substring.toLowerCase();
  return (String input) {
    if (substring.isEmpty) {
      return null;
    } else if (caseSensitive
        ? input.contains(substring)
        : input.toLowerCase().contains(lowercaseSubstring)) {
      return null;
    }
    return containsMsg?.call(substring, input) ??
        FormBuilderLocalizations.current.containsErrorText(substring);
  };
}

/// {@macro validator_starts_with}
Validator<String> startsWith(
  String prefix, {
  bool caseSensitive = true,
  String Function(String prefix, String input)? startsWithMsg,
}) {
  final String lowercasePrefix = prefix.toLowerCase();
  return (String input) {
    if (prefix.isEmpty) {
      return null;
    } else if (caseSensitive
        ? input.startsWith(prefix)
        : input.toLowerCase().startsWith(lowercasePrefix)) {
      return null;
    }
    return startsWithMsg?.call(prefix, input) ??
        FormBuilderLocalizations.current.startsWithErrorText(prefix);
  };
}

/// {@macro validator_ends_with}
Validator<String> endsWith(
  String suffix, {
  bool caseSensitive = true,
  String Function(String suffix, String input)? endsWithMsg,
}) {
  final String lowercaseSuffix = suffix.toLowerCase();
  return (String input) {
    if (suffix.isEmpty) {
      return null;
    } else if (caseSensitive
        ? input.endsWith(suffix)
        : input.toLowerCase().endsWith(lowercaseSuffix)) {
      return null;
    }
    return endsWithMsg?.call(suffix, input) ??
        FormBuilderLocalizations.current.endsWithErrorText(suffix);
  };
}

/// {@macro validator_lowercase}
Validator<String> lowercase({String Function(String input)? lowercaseMsg}) {
  return (String input) {
    return input.toLowerCase() == input
        ? null
        : lowercaseMsg?.call(input) ??
              FormBuilderLocalizations.current.lowercaseErrorText;
  };
}

/// {@macro validator_uppercase}
Validator<String> uppercase({String Function(String input)? uppercaseMsg}) {
  return (String input) {
    return input.toUpperCase() == input
        ? null
        : uppercaseMsg?.call(input) ??
              FormBuilderLocalizations.current.uppercaseErrorText;
  };
}

int _countWords(String s) => s
    .trim()
    .split(RegExp(r'\s+'))
    .where(
      (String s) => s.isNotEmpty,
    ) // this avoid the bug of splitting "" into [""].
    .length;

/// {@macro validator_max_words_count}
Validator<String> maxWordsCount(
  int max, {
  String Function(String input, int max)? maxWordsCountMsg,
}) {
  if (max < 0) {
    throw ArgumentError.value(max, 'max', 'This argument must not be negative');
  }
  return (String input) {
    return _countWords(input) <= max
        ? null
        : maxWordsCountMsg?.call(input, max) ??
              FormBuilderLocalizations.current.maxWordsCountErrorText(max);
  };
}

/// {@macro validator_min_words_count}
Validator<String> minWordsCount(
  int min, {
  String Function(String input, int min)? minWordsCountMsg,
}) {
  if (min < 0) {
    throw ArgumentError.value(min, 'min', 'This argument must not be negative');
  }
  return (String input) {
    return _countWords(input) >= min
        ? null
        : minWordsCountMsg?.call(input, min) ??
              FormBuilderLocalizations.current.minWordsCountErrorText(min);
  };
}

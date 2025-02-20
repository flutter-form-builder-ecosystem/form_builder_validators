import '../../localization/l10n.dart';
import 'constants.dart';

/// {@macro validator_in_list}
Validator<T> inList<T extends Object?>(
  List<T> values, {
  String Function(T input, List<T> values)? inListMsg,
}) {
  if (values.isEmpty) {
    throw ArgumentError.value(
        '[]', 'values', 'The list of values must not be empty');
  }
  final Set<T> setOfValues = values.toSet();
  return (T input) {
    return setOfValues.contains(input)
        ? null
        : inListMsg?.call(input, values) ??
            FormBuilderLocalizations.current.containsElementErrorText;
  };
}

/// {@macro validator_is_true}
Validator<T> isTrue<T extends Object>(
    {String Function(T input)? isTrueMsg,
    bool caseSensitive = false,
    bool trim = true}) {
  return (T input) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      input,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == true) {
      return null;
    }
    return isTrueMsg?.call(input) ??
        FormBuilderLocalizations.current.mustBeTrueErrorText;
  };
}

/// {@macro validator_false}
Validator<T> isFalse<T extends Object>(
    {String Function(T input)? isFalseMsg,
    bool caseSensitive = false,
    bool trim = true}) {
  return (T input) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      input,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == false) {
      return null;
    }
    return isFalseMsg?.call(input) ??
        FormBuilderLocalizations.current.mustBeFalseErrorText;
  };
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

import '../../localization/l10n.dart';
import 'constants.dart';

/// {@macro validator_greater_than}
Validator<T> greaterThan<T extends num>(T reference,
    {String Function(T input, T reference)? greaterThanMsg}) {
  return (T input) {
    return input > reference
        ? null
        : greaterThanMsg?.call(input, reference) ??
            FormBuilderLocalizations.current.greaterThanErrorText(reference);
  };
}

/// {@macro validator_greater_than_or_equal_to}
Validator<T> greaterThanOrEqualTo<T extends num>(T reference,
    {String Function(T input, T reference)? greaterThanOrEqualToMsg}) {
  return (T input) {
    return input >= reference
        ? null
        : greaterThanOrEqualToMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .greaterThanOrEqualToErrorText(reference);
  };
}

/// {@macro validator_less_than}
Validator<T> lessThan<T extends num>(T reference,
    {String Function(T input, T reference)? lessThanMsg}) {
  return (T input) {
    return input < reference
        ? null
        : lessThanMsg?.call(input, reference) ??
            FormBuilderLocalizations.current.lessThanErrorText(reference);
  };
}

/// {@macro validator_less_than_or_equal_to}
Validator<T> lessThanOrEqualTo<T extends num>(T reference,
    {String Function(T input, T reference)? lessThanOrEqualToMsg}) {
  return (T input) {
    return input <= reference
        ? null
        : lessThanOrEqualToMsg?.call(input, reference) ??
            FormBuilderLocalizations.current
                .lessThanOrEqualToErrorText(reference);
  };
}

/// {@macro validator_between}
Validator<T> between<T extends num>(T min, T max,
    {bool minInclusive = true,
    bool maxInclusive = true,
    String Function(
      T input,
      T min,
      T max,
      bool minInclusive,
      bool maxInclusive,
    )? betweenMsg}) {
  if (min > max) {
    throw ArgumentError.value(
        min, 'min', 'Min must be less than or equal to max(=$max)');
  }
  return (T input) {
    return (minInclusive ? input >= min : input > min) &&
            (maxInclusive ? input <= max : input < max)
        ? null
        : betweenMsg?.call(
              input,
              min,
              max,
              minInclusive,
              maxInclusive,
            ) ??
            FormBuilderLocalizations.current.betweenNumErrorText(
                min, max, minInclusive.toString(), maxInclusive.toString());
  };
}

// other possible validators: isPositive/isNegative, isMultipleOf, etc.

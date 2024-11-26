import '../localization/l10n.dart';
import 'constants.dart';

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

String betweenTmpMsg(
        bool leftInclusive, bool rightInclusive, num min, num max) =>
    'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$min and less than ${rightInclusive ? 'or equal to ' : ''}$max';

/// This function returns a validator that checks if the user input is between
/// `min` and `max`.
///
/// The comparison will be inclusive by default, but this behavior
/// can be changed by editing `leftInclusive` and `rightInclusive`.
///
/// If the input is valid, it returns `null`. Otherwise,
/// it returns an error message that is `betweenMsg`, or
/// `FormBuilderLocalizations.current.between(min, max)` if `betweenMsg`
/// was not provided.
Validator<T> between<T extends num>(T min, T max,
    {bool leftInclusive = true,
    bool rightInclusive = true,
    String Function(bool? leftInclusive, bool rightInclusive, num min, num max)?
        betweenMsg}) {
  assert(min <= max, 'Min must be less than or equal to max');
  return (T value) {
    return (leftInclusive ? value >= min : value > min) &&
            (rightInclusive ? value <= max : value < max)
        ? null
        : betweenMsg?.call(leftInclusive, rightInclusive, min, max) ??
            'Value must be greater than ${leftInclusive ? 'or equal to ' : ''}$min and less than ${rightInclusive ? 'or equal to ' : ''}$max';
  };
}

const greaterT = greaterThan;
const greaterTE = greaterThanOrEqual;
const lessT = lessThan;
const lessTE = lessThanOrEqual;

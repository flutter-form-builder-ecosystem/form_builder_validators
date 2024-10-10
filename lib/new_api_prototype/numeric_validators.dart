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

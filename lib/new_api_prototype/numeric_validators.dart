import '../localization/l10n.dart';
import 'constants.dart';

String greaterThanTmpMsg(num n) => 'Value must be greater than $n';

/// This function returns a validator that checks whether the user input is greater
/// than `n`. If the input is valid, the validator returns `null`. Otherwise, it
/// returns an error message. The error message is `greaterThanMsg`, or
/// `FormBuilderLocalizations.current.greaterThan(n)` if `betweenMsg`
/// was not provided.
Validator<T> greaterThan<T extends num>(T n,
    {String Function(num)? greaterThanMsg}) {
  return (T value) {
    return value > n ? null : greaterThanMsg?.call(n) ?? greaterThanTmpMsg(n);
  };
}

String greaterThanOrEqualToTmpMsg(num n) =>
    'Value must be greater than or equal to $n';

/// This function returns a validator that checks whether the user input is greater
/// than or equal to `n`. If the input is valid, the validator returns `null`. Otherwise, it
/// returns an error message. The error message is `greaterThanOrEqualMsg`, or
/// `FormBuilderLocalizations.current.greaterThanOrEqualTo(n)` if `betweenMsg`
/// was not provided.
Validator<T> greaterThanOrEqualTo<T extends num>(T n,
    {String Function(num)? greaterThanOrEqualToMsg}) {
  return (T value) {
    return value >= n
        ? null
        : greaterThanOrEqualToMsg?.call(n) ?? greaterThanOrEqualToTmpMsg(n);
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
const greaterTE = greaterThanOrEqualTo;
const lessT = lessThan;
const lessTE = lessThanOrEqual;
